import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  void build() {}

  final db = FirebaseFirestore.instance;

  Future<bool> checkChat(
      {required String usersId, required String contactId}) async {
    final data = await db
        .collection('users')
        .doc(usersId)
        .collection('chats')
        .doc(contactId)
        .get();
    return data.exists;
  }

  Future<void> createChat(
      {required String usersId, required String contactId}) async {
    final messagesDoc = FirebaseFirestore.instance.collection('messages').doc();

    await db
        .collection('users')
        .doc(usersId)
        .collection('chats')
        .doc(contactId)
        .set({
      'messagesId': messagesDoc.id,
      'contacts': contactId,
      'lastMessage': '',
      'timeSent': '',
    });
    await db
        .collection('users')
        .doc(contactId)
        .collection('chats')
        .doc(usersId)
        .set({
      'messagesId': messagesDoc.id,
      'contacts': usersId,
      'lastMessage': '',
      'timeSent': '',
    });
  }

  Future<String> getMessagesId(
      {required String usersId, required String contactId}) async {
    final data = await db
        .collection('users')
        .doc(usersId)
        .collection('chats')
        .doc(contactId)
        .get();
    return data['messagesId'];
  }
}
