import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';
import 'product_image_slider.dart';
import 'product_info_section.dart';

class ProductDetailView extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Slider
          ProductImageSlider(images: product.images, thumbnailUrl: product.thumbnail),

          // Product Info Section
          ProductInfoSection(product: product),
        ],
      ),
    );
  }
}
