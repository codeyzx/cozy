import 'dart:io';

import 'package:chyess/src/common_widgets/common_widgets.dart';
import 'package:chyess/src/constants/constants.dart';
import 'package:chyess/src/features/common/presentation/common_controller.dart';
import 'package:chyess/src/features/product/domain/product.dart';
import 'package:chyess/src/features/product/presentation/product_controller.dart';
import 'package:chyess/src/routes/app_routes.dart';
import 'package:chyess/src/shared/utils/picker.dart';
import 'package:chyess/src/shared/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ProductManagePage extends ConsumerWidget {
  const ProductManagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productControllerProvider);
    final controller = ref.read(productControllerProvider.notifier);
    return StatusBarWidget(
      brightness: Brightness.dark,
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 5.h, left: 25.w, right: 25.w),
            margin: EdgeInsets.only(bottom: 150.h, top: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.black),
                  iconSize: 20,
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                      side: BorderSide(
                          color: const Color(0xffCCD1D6), width: 0.3.w),
                    ),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(8),
                  ),
                ),
                Gap.h12,
                Text(
                  'Tambahkan Produk Baru',
                  style: TypographyApp.onBoardTitle.copyWith(fontSize: 23.sp),
                ),
                Form(
                    key: state.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap.h28,
                        Text(
                          'Foto Custom Pakaian',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        GestureDetector(
                          onTap: state.imageUrl == null
                              ? () async {
                                  await showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      backgroundColor: Colors.white,
                                      title: const Text(
                                        'Pilih Foto',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              try {
                                                final imageUrl =
                                                    await pickImage(
                                                        isCamera: false);
                                                if (imageUrl != null) {
                                                  controller
                                                      .setImageUrl(imageUrl);
                                                }
                                              } catch (e) {
                                                Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500),
                                                  () => showSnackBar(context,
                                                      Colors.red, e.toString()),
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey[300]!),
                                                ),
                                              ),
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    Icons.image,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Dari Galeri',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              try {
                                                final imageUrl =
                                                    await pickImage(
                                                        isCamera: true);
                                                if (imageUrl != null) {
                                                  controller
                                                      .setImageUrl(imageUrl);
                                                }
                                              } catch (e) {
                                                Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500),
                                                  () => showSnackBar(context,
                                                      Colors.red, e.toString()),
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Dari Kamera',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              : () {},
                          child: state.imageUrl == null
                              ? Container(
                                  height: 200.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 200.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(color: Colors.grey),
                                    image: DecorationImage(
                                      image: FileImage(File(state.imageUrl!)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                        Gap.h28,
                        Text(
                          'Foto 3D Pakaian (.glb/.gltf)',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        GestureDetector(
                          onTap: state.arUrl == null
                              ? () async {
                                  try {
                                    final arUrl = await pickAndUploadFile();
                                    if (arUrl != null) {
                                      controller.setArUrl(arUrl);
                                    }
                                  } catch (e) {
                                    Future.delayed(
                                      const Duration(milliseconds: 500),
                                      () => showSnackBar(
                                          context, Colors.red, e.toString()),
                                    );
                                  }
                                }
                              : () {},
                          child: state.arUrl == null
                              ? Container(
                                  height: 200.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 200.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: ModelViewer(
                                    backgroundColor: const Color.fromARGB(
                                        0xFF, 0xEE, 0xEE, 0xEE),
                                    src: state.arUrl ?? '',
                                    alt: 'AR View Design',
                                    ar: true,
                                    autoRotate: true,
                                    disableZoom: false,
                                    loading: Loading.lazy,
                                  ),
                                ),
                        ),
                        Gap.h28,
                        Text(
                          'Nama Custom',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        InputFormWidget(
                          controller: state.nameController,
                          hintText: 'Dress dengan motif khas Indonesia',
                          keyboardType: TextInputType.text,
                          validator: validate,
                        ),
                        Gap.h28,
                        Text(
                          'Kategori Custom',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        DropdownWidget(
                          style: TypographyApp.loginOffInput.copyWith(
                              fontSize: 15.sp, fontWeight: FontWeight.w500),
                          hintText: 'Baju',
                          items: const [
                            DropdownMenuItem(
                              value: 'Baju',
                              child: Text('Baju'),
                            ),
                            DropdownMenuItem(
                              value: 'Celana',
                              child: Text('Celana'),
                            ),
                            DropdownMenuItem(
                              value: 'Hoodie',
                              child: Text('Hoodie'),
                            ),
                            DropdownMenuItem(
                              value: 'Dress',
                              child: Text('Dress'),
                            ),
                            DropdownMenuItem(
                              value: 'Jaket',
                              child: Text('Jaket'),
                            ),
                            DropdownMenuItem(
                              value: 'Kemeja',
                              child: Text('Kemeja'),
                            ),
                            DropdownMenuItem(
                              value: 'Rok',
                              child: Text('Rok'),
                            ),
                            DropdownMenuItem(
                              value: 'Kaos',
                              child: Text('Kaos'),
                            ),
                            DropdownMenuItem(
                              value: 'Lainnya',
                              child: Text('Lainnya'),
                            ),
                          ],
                          value: state.category,
                          onChanged: controller.setCategory,
                        ),
                        Gap.h28,
                        Text(
                          'Deskripsi Produk',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        InputFormWidget(
                          controller: state.descController,
                          hintText:
                              'Seorang desainer yang sudah berpengalaman selama 5 tahun dalam dunia fashion.',
                          keyboardType: TextInputType.text,
                          maxLines: 4,
                          validator: validate,
                        ),
                        Gap.h28,
                        Text(
                          'Stok Barang',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        InputFormWidget(
                          controller: state.stockController,
                          keyboardType: TextInputType.number,
                          hintText: '25',
                        ),
                        Gap.h28,
                        Text(
                          'Harga Barang',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        InputFormWidget(
                          controller: state.priceController,
                          keyboardType: TextInputType.number,
                          hintText: 'Rp50.000',
                        ),
                        Gap.h28,
                        Text(
                          'Bahan Custom',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        InputFormWidget(
                          controller: state.materialsController,
                          hintText: 'Katun dan Sutra',
                          keyboardType: TextInputType.text,
                          validator: validate,
                        ),
                        Gap.h28,
                        Text(
                          'Ukuran yang Tersedia',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        InputFormWidget(
                          controller: state.sizesController,
                          hintText: 'XS, S, M, L, XL, XXL, XXXL',
                          keyboardType: TextInputType.text,
                          validator: validate,
                        ),
                        Gap.h28,
                        Text(
                          'Warna yang Tersedia',
                          style: TextStyle(
                            color: ColorApp.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap.h8,
                        InputFormWidget(
                          controller: state.colorsController,
                          hintText: 'Merah, Biru, Hijau, Kuning',
                          keyboardType: TextInputType.text,
                          validator: validate,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.all(16),
          width: 1.sw,
          height: 100.h,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: ColorApp.shadow.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ]),
          child: ButtonWidget.primary(
            text: 'Tambahkan Produk',
            isLoading: state.loadingValue is AsyncLoading,
            onTap: state.loadingValue is AsyncLoading
                ? () {}
                : () async {
                    if (!state.formKey.currentState!.validate()) {
                      return;
                    }
                    if (state.imageUrl == null) {
                      hideSnackBar(context);
                      showSnackBar(
                          context, Colors.red, 'Foto tidak boleh kosong');
                      return;
                    }

                    final user = ref
                        .read(commonControllerProvider)
                        .userValue
                        .asData
                        ?.value;

                    final imageUrl = state.imageUrl != null
                        ? state.imageUrl!.contains('https')
                            ? state.imageUrl!
                            : await uploadImages(state.imageUrl!,
                                path: 'products')
                        : '';

                    Product product = Product(
                      name: state.nameController.text,
                      category: state.category,
                      description: state.descController.text,
                      qty: int.parse(state.stockController.text),
                      price: int.parse(state.priceController.text),
                      materials: state.materialsController.text,
                      sizes: state.sizesController.text,
                      colors: state.colorsController.text,
                      imageUrl: imageUrl,
                      arUrl: state.arUrl,
                      city: user?.city,
                      location: user?.address,
                      designer: user,
                      isArAvailable: state.arUrl != null,
                      rating: 0,
                      sold: 0,
                    );

                    await controller.addProduct(product);

                    controller.setEmpty();

                    await ref
                        .read(commonControllerProvider.notifier)
                        .fetchDesigners();
                    await controller.fetchProducts();

                    Future.delayed(
                      const Duration(milliseconds: 800),
                      () => showSnackBar(
                          context, Colors.green, 'Berhasil Menambahkan Produk'),
                    );

                    ref.read(goRouterProvider).goNamed(Routes.botNavBar.name);
                  },
          ),
        ),
      ),
    );
  }
}
