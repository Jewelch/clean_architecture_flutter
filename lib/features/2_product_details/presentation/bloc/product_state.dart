import 'package:equatable/equatable.dart';

import '../../domain/entities/product_entity.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

final class ProductInitialState extends ProductState {
  const ProductInitialState();
}

final class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

final class ProductLoadedState extends ProductState {
  final ProductEntity product;

  const ProductLoadedState({required this.product});

  @override
  List<Object?> get props => [product];
}

final class ProductErrorState extends ProductState {
  final String errorMessage;

  const ProductErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

final class ProductEmptyState extends ProductState {
  const ProductEmptyState();
}
