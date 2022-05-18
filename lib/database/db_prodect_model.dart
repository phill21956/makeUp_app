class Product {
  int? id;
  final String title;
    final String image;
    final String? price;
  final double? ratings;

  bool isChecked;

  Product(
      {this.id,
      required this.title,
      required this.price,
      required this.image,
      this.ratings,
      required this.isChecked});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'ratings': ratings,
      'isChecked': isChecked ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'product(id : $id, title: $title, price: $price, image: $image, ratings: $ratings, isChecked: $isChecked)';
  }
}
