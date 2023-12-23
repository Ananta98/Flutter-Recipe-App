import 'package:recipe_app/models/meal.dart';

class MealPlan {
  final List<Meal> meals;
  final double calories;
  final double carbs;
  final double fat;
  final double proteins;

  MealPlan({required this.meals, required this.calories, required this.carbs, required this.fat, required this.proteins});

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    List<Meal> meals = [];
    json['meals'].forEach((meal) => meals.add(Meal.fromJson(meal)));
    return MealPlan(
      calories: json['nutrients']['calories'],
      carbs: json['nutrients']['carbohydrates'],
      fat: json['nutrients']['fat'],
      proteins: json['nutrients']['protein'],
      meals : meals);
  }
}