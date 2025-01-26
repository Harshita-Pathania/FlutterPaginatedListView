// Importing libraries and custom widgets
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/home_view_model.dart';
import 'custom_app_bar.dart';
import 'drawer.dart';
import 'list_view.dart';
import 'search_bar.dart';

// Consumer widget that represents HomePage
// Listens to changes in ViewModel and changes accordingly
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access ViewModel using Provider
    final viewModel = ref.watch(homeViewModelProvider);
    // Get list of filtered items
    final filteredItems = viewModel.filteredItems;

    // Return layout of HomePage
    return Scaffold(
      appBar: custom_app_bar(),
      drawer: MyDrawer(),
      body: Column(
        children: [
          CustomSearchBar(
            onSearchChanged: (query) {
              // Update searchQuery when user types
              ref.read(homeViewModelProvider.notifier).updateSearchQuery(query);
            },
          ),
          // Expands to fill remaining space
          Expanded(
            child: list_view(
              // Passes filtered items to display
              items: filteredItems,
              // Loads more data on scrolling
              onLoadMoreUp: () => ref.read(homeViewModelProvider.notifier).loadMoreData('up'),
              onLoadMoreDown: () => ref.read(homeViewModelProvider.notifier).loadMoreData('down'),
              isLoading: viewModel.isLoading,
              searchQuery: viewModel.searchQuery,
            ),
          ),
        ],
      ),
    );
  }
}
