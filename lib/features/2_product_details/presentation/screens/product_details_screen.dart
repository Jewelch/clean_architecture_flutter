import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_detail_view.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductEvent(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ProductBloc>().add(RefreshProductEvent(widget.productId));
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          debugPrint('state: $state');

          return switch (state) {
            ProductInitialState() => const Center(child: Text('Initializing...')),
            ProductLoadingState() => const Center(child: CircularProgressIndicator()),
            ProductErrorState(errorMessage: final message) => Center(child: Text('Error: $message')),
            ProductEmptyState() => const Center(child: Text('No product found!')),
            ProductLoadedState(product: final product) => ProductDetailView(product: product),
          };
        },
      ),
    );
  }
}
