import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.availableMeals,
  });
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;
  void _selectScreen(BuildContext context, Category category) {
    final filteredMeals =
        availableMeals
            .where((meals) => meals.categories.contains(category.id))
            .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
              onToggleFavorite: onToggleFavorite,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        //--> one way to print data on screen
        // ...availableCategories.map(
        //   (category) => CategoryGridItem(category: category),
        // ),

        // --> another way to
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectScreen(context, category);
            },
          ),
      ],
    );
  }
}
