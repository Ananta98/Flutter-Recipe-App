import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class RecipeScreen extends StatefulWidget {
  String mealType;
  Recipe recipe;
  RecipeScreen({super.key, required this.mealType, required this.recipe});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.recipe.spoonacularSourceUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.mealType),
        ),
        body: WebViewWidget(controller: controller!));
  }
}
