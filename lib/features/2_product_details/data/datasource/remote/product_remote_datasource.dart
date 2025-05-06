import 'dart:math';

import 'package:jch_requester/generic_requester.dart';

import '../../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel?> getProduct();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final RequestPerformer _apiClient;

  // Injecting the apiClient
  ProductRemoteDataSourceImpl({required RequestPerformer requestPerformer}) : _apiClient = requestPerformer;

  @override
  Future<ProductModel?> getProduct() async {
    // Generate a random product ID between 1 and 100
    final randomId = Random().nextInt(100) + 1;

    return await _apiClient.performDecodingRequest(
      debugIt: false,
      method: RestfulMethods.get,
      path: 'products/$randomId',
      decodableModel: ProductModel(),
    );
  }
}
