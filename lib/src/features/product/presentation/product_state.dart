import 'package:chyess/src/features/product/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ProductState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<bool?> loadingValue;
  final AsyncValue<List<Product>?> searchProducts;
  final AsyncValue<List<Product>?> products;
  final AsyncValue<Product?> product;
  final TextEditingController searchController;
  final TextEditingController nameController;
  final TextEditingController stockController;
  final TextEditingController materialsController;
  final TextEditingController sizesController;
  final TextEditingController colorsController;
  final TextEditingController descController;
  final TextEditingController priceController;
  final String? imageUrl;
  final String? arUrl;
  final String? category;

  ProductState({
    this.searchProducts = const AsyncLoading(),
    this.loadingValue = const AsyncData(null),
    this.products = const AsyncLoading(),
    this.product = const AsyncLoading(),
    required this.nameController,
    required this.stockController,
    required this.materialsController,
    required this.sizesController,
    required this.colorsController,
    required this.descController,
    required this.priceController,
    required this.searchController,
    this.imageUrl,
    this.arUrl,
    this.category,
  });

  ProductState copyWith({
    AsyncValue<bool?>? loadingValue,
    AsyncValue<List<Product>?>? searchProducts,
    AsyncValue<List<Product>?>? products,
    AsyncValue<Product?>? product,
    TextEditingController? searchController,
    TextEditingController? nameController,
    TextEditingController? stockController,
    TextEditingController? materialsController,
    TextEditingController? sizesController,
    TextEditingController? colorsController,
    TextEditingController? descController,
    TextEditingController? priceController,
    String? imageUrl,
    String? arUrl,
    String? category,
  }) {
    return ProductState(
      loadingValue: loadingValue ?? this.loadingValue,
      searchProducts: searchProducts ?? this.searchProducts,
      products: products ?? this.products,
      product: product ?? this.product,
      searchController: searchController ?? this.searchController,
      nameController: nameController ?? this.nameController,
      stockController: stockController ?? this.stockController,
      materialsController: materialsController ?? this.materialsController,
      sizesController: sizesController ?? this.sizesController,
      colorsController: colorsController ?? this.colorsController,
      descController: descController ?? this.descController,
      priceController: priceController ?? this.priceController,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      arUrl: arUrl ?? this.arUrl,
    );
  }
}
