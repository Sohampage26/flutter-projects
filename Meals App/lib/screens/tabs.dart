import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
// import 'package:meals/data/dummy_data.dart';
// import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/dropdown_select.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/imageUp.dart';
import 'package:meals/screens/meales.dart';
import 'package:meals/widgets/expenses.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals/providers/meals_provider.dart';
import 'package:meals/providers/favourites_provider.dart';
import 'package:meals/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenfree: false,
  Filter.lactosefree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabscreenState();
  }
}

class _TabscreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favouriteMeals = [];
  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  // void _toggleMealFavouriteStatus(Meal meal) {
  //   final isExisting = _favouriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favouriteMeals.remove(meal);
  //       _showInfoMessage('Meal removed as Favourite');
  //     });
  //   } else {
  //     setState(() {
  //       _favouriteMeals.add(meal);
  //       _showInfoMessage('Meal Added as Favourite');
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    // Log tab selection event
    FirebaseAnalytics.instance.logEvent(
      name: 'navigate_drawer',
      parameters: {
        'destination': index == 0
            ? 'categories_screen'
            : index == 1
                ? 'favourites_screen'
                : index == 2
                    ? 'image_upload_screen'
                    : index == 3
                        ? 'expense_tracker_screen'
                        : 'DropDown',
      },
    );
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      // final result =
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(
              // currentFilters: _selectedFilters,
              ),
        ),
      );
      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
      FirebaseAnalytics.instance.logEvent(
        name: 'navigate_drawer',
        parameters: {
          'destination': 'filters_screen',
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final meals = ref.watch(mealsProvider);
    // final activeFilters = ref.watch(filtersProvider);
    final availableMeals = ref.watch(filteredMealsProvider);
    //meals.where((meal) {
    //   if (activeFilters[Filter.glutenfree]! && !meal.isGlutenFree) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.lactosefree]! && !meal.isLactoseFree) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
    //     return false;
    //   }
    //   if (activeFilters[Filter.vegan]! && !meal.isVegan) {
    //     return false;
    //   }
    //   return true;
    // }).toList();
    Widget activePage = CategoriesScreen(
      // onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(
        meals: favouriteMeals,
        // onToggleFavourite: _toggleMealFavouriteStatus,
      );
      activePageTitle = 'Your Favourites';
    }

    if (_selectedPageIndex == 2) {
      activePage = const ImageUp();
      activePageTitle = 'Image Upload';
    }

    if (_selectedPageIndex == 3) {
      activePage = const Expenses();
      activePageTitle = 'Expense Tracker';
    }
    if (_selectedPageIndex == 4) {
      activePage = const DropdownSelect();
      activePageTitle = 'DropDown';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image_search),
            label: 'Upload Image',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'expense_tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_drop_down),
            label: 'DropDown',
          ),
        ],
      ),
    );
  }
}
