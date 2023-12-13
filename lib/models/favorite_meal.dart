class FavoriteMeal {
  final int id;
  final String title;
  final String thumbnail;

  FavoriteMeal({
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

  factory FavoriteMeal.fromMap(Map<String, dynamic> map) {
    return FavoriteMeal(
      id: map['id'],
      title: map['title'],
      thumbnail: map['thumbnail'],
    );
  }
}
