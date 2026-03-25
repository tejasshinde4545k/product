class Product {
  final int productId;
  final String productName;
  final String category;
  final String mainCategory;
  final int mrp;

  Product({
    required this.productId,
    required this.productName,
    required this.category,
    required this.mainCategory,
    required this.mrp,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json["product_id"],
      productName: json["product_name"],
      category: json["category"],
      mainCategory: json["main_category"],
      mrp: json["mrp"],
    );
  }
}
