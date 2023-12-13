// favorite_meal_model.dart
class FavoriteMealModel {
  final String id;
  final String title;
  final String thumbnailUrl;

  FavoriteMealModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory FavoriteMealModel.fromMap(Map<String, dynamic> map) {
    return FavoriteMealModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
