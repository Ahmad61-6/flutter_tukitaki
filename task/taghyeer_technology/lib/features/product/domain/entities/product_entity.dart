class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String thumbnail;

  ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });
}

class PaginatedProductsEntity {
  final List<ProductEntity> products;
  final int total;

  PaginatedProductsEntity({required this.products, required this.total});
}