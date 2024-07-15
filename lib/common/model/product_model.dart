class ProductModel {
  final int id;
  final String title;
  final String imageUrl;
  final String price;
  factory ProductModel.formJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        imageUrl: removeCharacter(json['images'][0]),
        price: json['price'].toString());
  }
  ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });
}

String removeCharacter(String text) {
  text = text.replaceAll('[', '');
  text = text.replaceAll(']', '');
  text = text.replaceAll('"', '');
  return text;
}

class ProductDetailsModel {
  final int id;
  final String title;
  final List<String> imageUrl;
  final String price;
  final String description;

  ProductDetailsModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.price,
      required this.description});
  factory ProductDetailsModel.formJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      title: json['title'],
      imageUrl: List.castFrom(json['images']),
      price: json['price'].toString(),
      description: json['description'],
    );
  }
}
