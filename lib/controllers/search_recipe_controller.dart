import 'package:get/get.dart';
import 'package:recipe_app/models/meal_plan.dart';
import 'package:recipe_app/pages/meal_screen.dart';
import 'package:recipe_app/services/api_service.dart';

class SearchRecipeController extends GetxController {
  RxList<String> diets = RxList<String>([
    'None',
    'Gluten Free',
    'Ketogenic',
    'Lacto-Vegetarian',
    'Ovo-Vegetarian',
    'Vegan',
    'Pescetarian',
    'Paleo',
    'Primal',
    'Whole30'
  ]);

  RxString diet = RxString('None');

  RxDouble targetCalories = RxDouble(2500);

  ApiService api = ApiService();

  void changeValueTargetCalories(double value) {
    targetCalories.value = value.round().toDouble();
  }

  void changeValueDiet(String value) {
    diet.value = value;
  }

  void searchMealPlan() async {
    MealPlan mealPlan = await api.generateMealPlan(targetCalories: targetCalories.round(), diet: diet.value);
    Get.to(MealScreen(mealPlan: mealPlan,));
  }
}