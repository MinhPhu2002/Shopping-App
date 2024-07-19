class BrandModel {
  final int id;
  final String name;
  final String imageUrl;
  factory BrandModel.formJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image'],
    );
  }

  BrandModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}
