import 'package:flutter/material.dart';
import 'package:recipe_app/utils/store.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/ui/widgets/recipe_card.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // New member of the class:
  List<Recipe> recipes = getRecipes();
  List<String> userFavorites = getFavoriteIDs();

  // New method:
  // Inactive widgets are going to call this method to
  // signalize the parent widget HomeScreen to refresh the list view.

  void _handleFavoritesListChanged(String recipeID) {
    // Set new state and refresh the widget:
    setState(() => userFavorites.contains(recipeID)
        ? userFavorites.remove(recipeID)
        : userFavorites.add(recipeID));
  }

  @override
  Widget build(BuildContext context) {

    Column _buildRecipes(List<Recipe> recipesList) {
      return Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: recipesList.length,
              itemBuilder: (BuildContext context, index) {
                return RecipeCard(
                  recipe: recipesList[index],
                  inFavorites: userFavorites.contains(recipesList[index].id),
                  onFavoriteButtonPressed: _handleFavoritesListChanged,
                );
              },
            ),
          ),
        ],
      );
    }

    double _iconSize = 20.0;

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            bottom: TabBar(labelColor: Theme.of(context).indicatorColor, tabs: [
              Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
              Tab(icon: Icon(Icons.local_drink, size: _iconSize)),
              Tab(icon: Icon(Icons.favorite, size: _iconSize)),
              Tab(
                icon: Icon(Icons.settings, size: _iconSize),
              ),
            ]),
          ),
          body: Padding(
            padding: EdgeInsets.all(5.0),
            child: TabBarView(
              children: [
                // Display recipes of type food:
                _buildRecipes(recipes
                    .where((recipe) => recipe.type == RecipeType.food)
                    .toList()),
                // Display recipes of type drink:
                _buildRecipes(recipes
                    .where((recipe) => recipe.type == RecipeType.drink)
                    .toList()),
                // Display favorite recipes:
                _buildRecipes(recipes
                    .where((recipe) => userFavorites.contains(recipe.id))
                    .toList()),
                Center(child: Icon(Icons.settings)),
              ],
            ),
          ),
        ));
  }
}
