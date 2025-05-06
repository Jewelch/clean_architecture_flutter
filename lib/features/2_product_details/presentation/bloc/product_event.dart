import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

final class LoadProductEvent extends ProductEvent {
  const LoadProductEvent();
}

final class RefreshProductEvent extends ProductEvent {
  const RefreshProductEvent();
}
