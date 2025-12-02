import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../data/repositories/product_repository_impl.dart';

class ProductViewModel extends ChangeNotifier {
  final GetProductsUseCase getProducts;
  final ProductRepositoryImpl repository;

  ProductViewModel(this.getProducts, this.repository);

  List<Product> allProducts = [];
  List<Product> displayed = [];
  List<String> categories = [];

  bool loading = false;
  String? errorMessage;

  // pagination
  int pageSize = 10;
  int offset = 0;
  bool hasMore = true;

  // filters
  String? selectedCategory;
  String searchQuery = '';

  Future<void> loadInitial() async {
    loading = true;
    notifyListeners();

    try {
      allProducts = await getProducts.call(limit: 0, offset: 0);
      categories = await repository.getCategories();
      offset = 0;
      displayed = [];
      hasMore = true;
      _applyFiltersAndPaginate();
    } catch (e) {
      errorMessage = 'Error loading products';
    }

    loading = false;
    notifyListeners();
  }

  void _applyFiltersAndPaginate() {
    List<Product> filtered = allProducts;

    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      filtered = filtered.where((p) => p.category == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((p) => p.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    final end = (offset + pageSize) > filtered.length ? filtered.length : (offset + pageSize);
    displayed = filtered.sublist(0, end);
    hasMore = end < filtered.length;
  }

  void loadMore() {
    if (!hasMore) return;
    offset += pageSize;
    _applyFiltersAndPaginate();
    notifyListeners();
  }

  void applyCategory(String? category) {
    selectedCategory = category;
    offset = 0;
    _applyFiltersAndPaginate();
    notifyListeners();
  }

  void applySearch(String query) {
    searchQuery = query;
    offset = 0;
    _applyFiltersAndPaginate();
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadInitial();
  }
}
