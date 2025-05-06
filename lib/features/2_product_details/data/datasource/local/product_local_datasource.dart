import '../../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<ProductModel?> getProduct();
  Future<void> saveProduct(ProductModel product);
  Future<void> clearProduct();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  // In-memory storage for this example
  ProductModel? _cachedProduct;

  @override
  Future<ProductModel?> getProduct() async {
    // In a real app, this would fetch from SharedPreferences, Hive, or SQLite
    return _cachedProduct;
  }

  @override
  Future<void> saveProduct(ProductModel product) async {
    // In a real app, this would save to local storage
    _cachedProduct = product;
  }

  @override
  Future<void> clearProduct() async {
    // In a real app, this would clear the storage
    _cachedProduct = null;
  }
}
