import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controllers/search_recipe_controller.dart';

class SearchScreen extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SearchRecipeController());
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white.withOpacity(0.9)),
          height: MediaQuery.of(context).size.height * 0.55,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Daily Meal Planner",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Obx(() => RichText(
                        text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 25),
                            children: [
                          TextSpan(
                              text: controller.targetCalories
                                  .round()
                                  .toString()
                                  .trim(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold)),
                          const TextSpan(
                              text: ' cal',
                              style: TextStyle(fontWeight: FontWeight.w600))
                        ]))),
                SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbColor: Theme.of(context).primaryColor,
                        activeTrackColor: Theme.of(context).primaryColor,
                        inactiveTickMarkColor: Colors.lightBlue,
                        trackHeight: 6.0),
                    child: Obx(() => Slider(
                          min: 0.0,
                          max: 4500.0,
                          value: controller.targetCalories.value,
                          onChanged: (value) =>
                              controller.changeValueTargetCalories(value),
                        ))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(labelText: "Diet"),
                    items: controller.diets
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) => controller.changeValueDiet(value ?? "None"),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 50.0,
                  margin: const EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: TextButton(
                      onPressed: () => controller.searchMealPlan(),
                      child: const Center(
                        child: Text(
                          "Search",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
