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
  final String thumbnail;

  ProductDetailsModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.price,
      required this.description,
      required this.thumbnail});
  factory ProductDetailsModel.formJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      title: json['title'],
      imageUrl: List.castFrom(json['images']),
      price: json['price'].toString(),
      description: json['description'],
      thumbnail: json['thumbnail'],
    );
  }
}

class ProductCartModel {
  final int id;
  final String title;
  final String thumbnail;
  final String price;
  factory ProductCartModel.formJson(Map<String, dynamic> json) {
    return ProductCartModel(
        id: json['id'],
        title: json['title'],
        thumbnail: json['thumbnail'],
        price: json['price'].toString());
  }
  ProductCartModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
  });
}
