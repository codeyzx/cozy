import 'package:chyess/src/features/product/data/product_repository.dart';
import 'package:chyess/src/features/product/domain/product.dart';
import 'package:chyess/src/features/product/presentation/product_state.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'product_controller.g.dart';

@Riverpod(keepAlive: true)
class ProductController extends _$ProductController {
  @override
  ProductState build() {
    return ProductState(
      searchController: TextEditingController(),
      nameController: TextEditingController(),
      stockController: TextEditingController(),
      materialsController: TextEditingController(),
      sizesController: TextEditingController(),
      colorsController: TextEditingController(),
      descController: TextEditingController(),
      priceController: TextEditingController(),
    );
  }

  Future<void> fetchProducts() async {
    final result = await ref.read(productRepositoryProvider).getProducts();
    result.when(
      success: (products) {
        state = state.copyWith(
            products: AsyncData(products), searchProducts: AsyncData(products));
      },
      failure: (e, s) {
        state = state.copyWith(
            products: AsyncError(e, s), searchProducts: AsyncError(e, s));
      },
    );
  }

  Future<Product?> fetchProduct(String id) async {
    final result = await ref.read(productRepositoryProvider).getProduct(id);
    return result.when(
      success: (product) {
        return product;
      },
      failure: (e, s) {
        Logger().e(e);
        return null;
      },
    );
  }

  Future<void> addProduct(Product product) async {
    final result =
        await ref.read(productRepositoryProvider).addProduct(product);
    result.when(
      success: (_) {
        fetchProducts();
      },
      failure: (e, s) {
        state = state.copyWith(
            products: AsyncError(e, s), searchProducts: AsyncError(e, s));
      },
    );
  }

  Future<void> updateProduct(Map<String, String> product) async {
    final result =
        await ref.read(productRepositoryProvider).updateProduct(product);
    result.when(
      success: (_) {
        fetchProducts();
      },
      failure: (e, s) {
        state = state.copyWith(
            products: AsyncError(e, s), searchProducts: AsyncError(e, s));
      },
    );
  }

  Future<void> updateAllProductsByDesignerId(
      String designerId, Product product) async {
    final result = await ref
        .read(productRepositoryProvider)
        .updateAllProductsByDesignerId(designerId, product);
    result.when(
      success: (_) {
        fetchProducts();
      },
      failure: (e, s) {
        state = state.copyWith(
            products: AsyncError(e, s), searchProducts: AsyncError(e, s));
      },
    );
  }

  Future<void> addProducts() async {
    await ref.read(productRepositoryProvider).addProducts();
    fetchProducts();
  }

  Future<void> searchProducts() async {
    final query = state.searchController.text;
    if (query.isEmpty) {
      state = state.copyWith(searchProducts: state.products);
    }
    List<Product> products = state.products.asData!.value ?? [];
    final result = products
        .where((product) =>
            product.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    state = state.copyWith(searchProducts: AsyncData(result));
  }

  void setImageUrl(String imageUrl) {
    state = state.copyWith(
      imageUrl: imageUrl,
    );
  }

  void setArUrl(String arUrl) {
    state = state.copyWith(
      arUrl: arUrl,
    );
  }

  void setCategory(String? category) {
    state = state.copyWith(
      category: category,
    );
  }

  void setDefaultvalue(Map<String, String> product) {
    state = state.copyWith(
      nameController: TextEditingController(text: product['name']),
      stockController: TextEditingController(text: product['stock']),
      materialsController: TextEditingController(text: product['materials']),
      sizesController: TextEditingController(text: product['sizes']),
      colorsController: TextEditingController(text: product['colors']),
      descController: TextEditingController(text: product['desc']),
      priceController: TextEditingController(text: product['price']),
      arUrl: product['arUrl'],
      imageUrl: product['imageUrl'],
      category: product['category'],
    );
  }

  void setEmpty() {
    state = state.copyWith(
      nameController: TextEditingController(),
      stockController: TextEditingController(),
      materialsController: TextEditingController(),
      sizesController: TextEditingController(),
      colorsController: TextEditingController(),
      descController: TextEditingController(),
      priceController: TextEditingController(),
      arUrl: '',
      imageUrl: '',
      category: '',
    );
  }
}
