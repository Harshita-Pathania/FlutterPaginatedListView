import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/home_view_model.dart';
import 'custom_app_bar.dart';
import 'drawer.dart';
import 'list_view.dart';
import 'search_bar.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModelProvider);
    final filteredItems = viewModel.filteredItems;

    return Scaffold(
      appBar: custom_app_bar(),
      drawer: MyDrawer(),
      body: Column(
        children: [
          CustomSearchBar(
            onSearchChanged: (query) {
              ref.read(homeViewModelProvider.notifier).updateSearchQuery(query);
            },
          ),
          Expanded(
            child: list_view(
              items: filteredItems,
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
