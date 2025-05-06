import '../../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<ProductModel?> getProduct([int? productId]);
  Future<void> saveProduct(ProductModel product);
  Future<void> clearProduct();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  // In-memory storage for this example
  final Map<int, ProductModel> _cachedProducts = {};

  @override
  Future<ProductModel?> getProduct([int? productId]) async {
    // In a real app, this would fetch from SharedPreferences, Hive, or SQLite
    if (productId != null) {
      return _cachedProducts[productId];
    }
    // Return any product if no specific ID is requested
    return _cachedProducts.isNotEmpty ? _cachedProducts.values.first : null;
  }

  @override
  Future<void> saveProduct(ProductModel product) async {
    // In a real app, this would save to local storage
    if (product.id != null) {
      _cachedProducts[product.id!] = product;
    }
  }

  @override
  Future<void> clearProduct() async {
    // In a real app, this would clear the storage
    _cachedProducts.clear();
  }
}
