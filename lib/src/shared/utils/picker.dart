import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as image_reduce;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> pickAndUploadFile() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    final File file = File(result.files.single.path!);
    final Uint8List bytes = file.readAsBytesSync();
    final String fileName = file.path.split('/').last;
    final String path = 'ar/$fileName';
    final UploadTask task =
        FirebaseStorage.instance.ref().child(path).putData(bytes);
    final TaskSnapshot snapshot = await task.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }
  return null;
}

Future<String?> pickImage({required bool isCamera}) async {
  if (isCamera) {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // Get the temporary directory
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;

      // Resize the image
      image_reduce.Image image =
          image_reduce.decodeImage(File(pickedFile.path).readAsBytesSync())!;
      image_reduce.copyResize(image, width: 500);

      // Compress and save the image
      final compressedImage = File('$path/img_$image.jpg')
        ..writeAsBytesSync(image_reduce.encodeJpg(image, quality: 85));

      // Upload the image to Firebase Storage
      final imageUrl = compressedImage.path;
      return imageUrl;
    }
  } else {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Check if the file has a valid image extension
      final validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
      final String extension = pickedFile.path.split('.').last.toLowerCase();
      if (!validExtensions.contains(extension)) {
        throw Exception('Only allowed extensions are jpg, jpeg, png, and gif.');
      }

      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      final File imageFile = File(pickedFile.path);
      final image_reduce.Image image =
          image_reduce.decodeImage(imageFile.readAsBytesSync())!;

      // Resize the image
      final image_reduce.Image resizedImage =
          image_reduce.copyResize(image, width: 500);

      // Compress and save the image
      final compressedImageFile = File('$path/img_$image.$extension')
        ..writeAsBytesSync(image_reduce.encodeJpg(resizedImage, quality: 85));

      // Upload the image to Firebase Storage
      final imageUrl = compressedImageFile.path;
      return imageUrl;
    }
  }
  return null;
}

Future<String> uploadImages(String imagesPath, {String? path}) async {
  final value = await FirebaseStorage.instance
      .ref()
      .child(path != null
          ? '$path/images/${DateTime.now().millisecondsSinceEpoch}.${imagesPath.split('.').last}'
          : 'users/images/${DateTime.now().millisecondsSinceEpoch}.${imagesPath.split('.').last}')
      .putFile(File(imagesPath));
  return value.ref.getDownloadURL();
}

Future<String> uploadFile(String filePath, {String? path}) async {
  final value = await FirebaseStorage.instance
      .ref()
      .child(path != null
          ? '$path/files/${DateTime.now().millisecondsSinceEpoch}.${filePath.split('.').last}'
          : 'users/files/${DateTime.now().millisecondsSinceEpoch}.${filePath.split('.').last}')
      .putFile(File(filePath));
  return value.ref.getDownloadURL();
}
