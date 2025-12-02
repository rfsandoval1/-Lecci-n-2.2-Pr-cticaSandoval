import '../../domain/entities/product.dart';
import '../datasources/fakestore_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl {
  final FakeStoreDataSource datasource;

  ProductRepositoryImpl(this.datasource);

  Future<List<Product>> getProducts({int limit = 10, int offset = 0}) async {
    final List<ProductModel> all = await datasource.fetchAllProducts();
    // client-side pagination
    if (offset >= all.length) return [];

    // if limit <= 0 treat as "all"
    if (limit <= 0) return all;

    final end = (offset + limit) > all.length ? all.length : (offset + limit);
    return all.sublist(offset, end);
  }

  Future<List<String>> getCategories() async {
    final all = await datasource.fetchAllProducts();
    final cats = all.map((e) => e.category).toSet().toList();
    return cats;
  }
}
