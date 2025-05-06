import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductUC {
  final ProductRepository repository;

  GetProductUC(this.repository);

  Future<ProductEntity?> execute() async {
    return await repository.getProduct();
  }
}
