import 'package:dio/dio.dart';
import 'package:recipe_app/models/meal_plan.dart';
import 'package:recipe_app/models/recipe.dart';

class ApiService {
  String apiKey = "31476ce595de4cd08953d1024a62710c";
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://api.spoonacular.com/",
      headers: {"Accept": "application/json", "Content-Type" : "application/json"}
    )
  );

  Future<MealPlan> generateMealPlan({int? targetCalories, String? diet}) async {
    if (diet == 'None') diet = '';
    Map<String, String> parameters = {
      "apiKey" : apiKey,
      "diet" : diet!,
      "targetCalories" : targetCalories.toString(),
      "timeFrame" : "day"
    };
    try {
      var response = await dio.get("/recipes/mealplans/generate", queryParameters: parameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return MealPlan.fromJson(response.data);
      }
      throw "Occured An Error";
    } on DioException catch (e) {
      throw e.toString();
    }
  }

  Future<Recipe> fetchRecipe(int id) async {
    Map<String, String> parameters = {
      "apiKey" : apiKey,
      "includeNutrition" : "false"
    };
    try {
      var response = await dio.get("/recipes/$id/information", queryParameters: parameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Recipe.fromJson(response.data);
      }
      throw "Occured An Error";
    } on DioException catch (e) {
      throw e.toString();
    }
  }
}
