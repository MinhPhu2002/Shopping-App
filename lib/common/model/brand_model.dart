class BrandModel {
  final String slug;
  final String name;
  final String imageUrl;
  factory BrandModel.formJson(Map<String, dynamic> json) {
    return BrandModel(
      slug: json['slug'],
      name: json['name'],
      imageUrl: json['url'],
    );
  }

  BrandModel({
    required this.slug,
    required this.name,
    required this.imageUrl,
  });
}
