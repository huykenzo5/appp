class Place {
  final int id;
  final String name;
  final String imageAsset; // local asset name
  final double rating;

  Place({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.rating,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: int.parse(json['id']),
      name: json['name'],
      imageAsset: 'assets/images/${json['image_url']}', // dùng giá trị làm tên file
      rating: double.parse(json['rating']),
    );
  }
}
