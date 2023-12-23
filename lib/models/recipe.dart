class Recipe {
  final String spoonacularSourceUrl;

  Recipe({required this.spoonacularSourceUrl});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(spoonacularSourceUrl: json["spoonacularSourceUrl"]);
  }
}