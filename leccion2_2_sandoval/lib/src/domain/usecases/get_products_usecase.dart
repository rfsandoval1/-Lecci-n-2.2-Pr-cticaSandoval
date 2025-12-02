import '../../domain/entities/product.dart';
import '../../data/repositories/product_repository_impl.dart';

class GetProductsUseCase {
  final ProductRepositoryImpl repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> call({int limit = 10, int offset = 0}) {
    return repository.getProducts(limit: limit, offset: offset);
  }
}
