import '../../../../core/managers/connectivity_manager.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/local/product_local_datasource.dart';
import '../datasource/remote/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final ConnecetivityManager connectivity;

  ProductRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.connectivity});

  @override
  Future<ProductEntity?> getProduct() async {
    try {
      if (connectivity.isConnected) {
        // Try to get from remote first
        final product = await remoteDataSource.getProduct();

        if (product != null) {
          // Save to local cache
          localDataSource.saveProduct(product);
          // Return as entity
          return ProductEntity.fromModel(product);
        }
        return null;
      } else {
        // Try to get from local
        final localProduct = await localDataSource.getProduct();
        // Return as entity if available
        return localProduct != null ? ProductEntity.fromModel(localProduct) : null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
