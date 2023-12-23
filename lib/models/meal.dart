class Meal {
  final int id;
  final String title;
  final String imageUrl;

  Meal({required this.id, required this.title, required this.imageUrl});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
        id: json["id"], title: json["title"], imageUrl: "${json["sourceUrl"]}.${json["imageType"]}}");
  }
}
