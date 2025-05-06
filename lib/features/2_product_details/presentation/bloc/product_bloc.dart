import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_product_uc.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUC getProductUC;

  ProductBloc({required this.getProductUC}) : super(const ProductInitialState()) {
    on<LoadProductEvent>(_onLoadProduct);
    on<RefreshProductEvent>(_onRefreshProduct);
  }

  Future<void> _onLoadProduct(LoadProductEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoadingState());

    try {
      final result = await getProductUC.execute(event.productId);

      if (result != null) {
        emit(ProductLoadedState(product: result));
      } else {
        emit(const ProductEmptyState());
      }
    } catch (e) {
      emit(ProductErrorState(errorMessage: 'Error loading product: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshProduct(RefreshProductEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoadingState());

    try {
      final result = await getProductUC.execute(event.productId);

      if (result != null) {
        emit(ProductLoadedState(product: result));
      } else {
        emit(const ProductEmptyState());
      }
    } catch (e) {
      emit(ProductErrorState(errorMessage: 'Error refreshing product: ${e.toString()}'));
    }
  }
}
