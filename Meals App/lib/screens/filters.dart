import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';

// enum Filter { glutenfree, lactosefree, vegetarian, vegan }

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});
  // final Map<Filter, bool> currentFilters;

//   @override
//   ConsumerState<FiltersScreen> createState() {
//     return _FiltersScreen();
//   }
// }

// class _FiltersScreen extends ConsumerState<FiltersScreen> {
//   var _glutenFreeFilterSet = false;
//   var _lactoseFreeFilterSet = false;
//   var _vegetarianFilterSet = false;
//   var _veganFilterSet = false;

//   @override
//   void initState() {
//     super.initState();
//     final activeFilters = ref.read(filtersProvider);
//     _glutenFreeFilterSet = activeFilters[Filter.glutenfree]!;
//     _lactoseFreeFilterSet = activeFilters[Filter.lactosefree]!;
//     _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
//     _veganFilterSet = activeFilters[Filter.vegan]!;
//   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (ctx) => const TabScreen()));
      //     }
      //   },
      // ),
      body: //  PopScope(
          //   canPop: true,
          //   onPopInvoked: (bool didPop) {
          //     if (didPop) {
          //       ref.read(filtersProvider.notifier).setFilters({
          //         Filter.glutenfree: _glutenFreeFilterSet,
          //         Filter.lactosefree: _lactoseFreeFilterSet,
          //         Filter.vegetarian: _vegetarianFilterSet,
          //         Filter.vegan: _veganFilterSet,
          //       });
          //       return;
          //     }

          //     // Navigator.of(context).pop();
          //   },
          Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenfree]!,
            onChanged: (isChecked) {
              //
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenfree, isChecked);
              FirebaseAnalytics.instance.logEvent(
                name: 'filter_toggle',
                parameters: <String, dynamic>{
                  'filter_name': 'Gluten-Free',
                  'filter_state': isChecked.toString(),
                },
              );
            },
            title: Text(
              'Gluten-Free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only Include gluten-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.lactosefree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactosefree, isChecked);
              FirebaseAnalytics.instance.logEvent(
                name: 'filter_toggle',
                parameters: <String, dynamic>{
                  'filter_name': 'Lactose-Free',
                  'filter_state': isChecked.toString()
                },
              );
            },
            title: Text(
              'Lactose-Free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only Include lactose-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
              FirebaseAnalytics.instance.logEvent(
                name: 'filter_toggle',
                parameters: <String, dynamic>{
                  'filter_name': 'Vegetarian',
                  'filter_state': isChecked.toString(),
                },
              );
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only Include Vegetarian meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
              FirebaseAnalytics.instance.logEvent(
                name: 'filter_toggle',
                parameters: <String, dynamic>{
                  'filter_name': 'Vegan',
                  'filter_state': isChecked.toString(),
                },
              );
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only Include Vegan meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
