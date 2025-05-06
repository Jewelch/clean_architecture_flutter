import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory ProductEntity.fromModel(ProductModel model) {
    return ProductEntity(
      id: model.id ?? 0,
      title: model.title ?? '',
      description: model.description ?? '',
      price: model.price ?? 0.0,
      discountPercentage: model.discountPercentage ?? 0.0,
      rating: model.rating ?? 0.0,
      stock: model.stock ?? 0,
      brand: model.brand ?? '',
      category: model.category ?? '',
      thumbnail: model.thumbnail ?? '',
      images: model.images ?? [],
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    discountPercentage,
    rating,
    stock,
    brand,
    category,
    thumbnail,
    images,
  ];
}
