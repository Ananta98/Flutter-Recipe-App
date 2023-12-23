import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/models/meal.dart';
import 'package:recipe_app/models/meal_plan.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/pages/recipe_screen.dart';
import 'package:recipe_app/services/api_service.dart';

// ignore: must_be_immutable
class MealScreen extends StatelessWidget {
  MealPlan mealPlan;
  MealScreen({super.key, required this.mealPlan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Meal Plan"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: mealPlan.meals.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return buildNutritientCard();
            }
            return buildMealCard(mealPlan.meals[index - 1], index - 1);
          }),
    );
  }

  Widget buildMealCard(Meal meal, int index) {
    String mealType = getMealType(index);
    return InkWell(
      onTap: () async {
        ApiService api = ApiService();
        Recipe recipe = await api.fetchRecipe(meal.id);
        Get.to(RecipeScreen(mealType: mealType, recipe: recipe));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 220.0,
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                    image: NetworkImage(meal.imageUrl), fit: BoxFit.cover),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 6.0)
                ]),
          ),
          Container(
            margin: const EdgeInsets.all(60.0),
            padding: const EdgeInsets.all(10.0),
            color: Colors.white70,
            child: Column(
              children: [
                Text(
                  mealType,
                  style: const TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  meal.title,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String getMealType(int index) {
    switch (index) {
      case 0:
        return "Breakfast";
      case 1:
        return "Launch";
      case 2:
        return "Dinner";
      default:
        return "Breakfast";
    }
  }

  Widget buildNutritientCard() {
    return Container(
      height: 140,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Total Nutrients",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Calories: ${mealPlan.calories.toString()} cal",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                "Protein: ${mealPlan.proteins.toString()} g",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Carbs: ${mealPlan.carbs.toString()} cal",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                "Fat: ${mealPlan.fat.toString()} g",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
