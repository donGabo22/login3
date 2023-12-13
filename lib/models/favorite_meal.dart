class FavoriteMealModel {
  final int id;
  final String title;
  final String thumbnail;

  FavoriteMealModel({
    required this.id,
    required this.title,
    required this.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
    };
  }

  factory FavoriteMealModel.fromMap(Map<String, dynamic> map) {
    return FavoriteMealModel(
      id: map['id'],
      title: map['title'],
      thumbnail: map['thumbnail'],
    );
  }
}