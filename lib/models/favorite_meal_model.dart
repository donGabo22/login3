//clase models solo para bd
class FavoriteMealModel {
  final String id;

  FavoriteMealModel({
    required this.id,
  });

  factory FavoriteMealModel.fromMap(Map<String, dynamic> map) {
    return FavoriteMealModel(
      id: map['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
