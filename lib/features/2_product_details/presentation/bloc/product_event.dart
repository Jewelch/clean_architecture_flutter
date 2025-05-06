import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

final class LoadProductEvent extends ProductEvent {
  final int productId;

  const LoadProductEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

final class RefreshProductEvent extends ProductEvent {
  final int productId;

  const RefreshProductEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}
