import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/mock_api.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(HomeState()) {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    state = state.copyWith(isLoading: true);

    try {
      var response = await fetchItems(id: state.lastId, direction: 'down');
      state = state.copyWith(
        items: response['data'],
        lastId: response['data'].isNotEmpty ? response['data'].last['id'] : 50,
        isLoading: false,
      );
    } catch (e) {
      // Handle errors (e.g., API failure)
      state = state.copyWith(isLoading: false);
      print("Error fetching initial data: $e");
    }
  }

  Future<void> loadMoreData(String direction) async {
    if (state.isLoading) return; // Avoid multiple requests at once

    int fetchId = direction == 'down' ? state.lastId : state.items.first['id'];

    // Check boundaries
    if ((direction == 'down' && fetchId >= 2000) ||
        (direction == 'up' && fetchId <= 1)) {
      print("Reached boundary. No more data to fetch.");
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      var response = await fetchItems(id: fetchId, direction: direction);
      var newItems = response['data'];

      if (newItems.isNotEmpty) {
        state = state.copyWith(
          items: direction == 'down'
              ? [...state.items, ...newItems.where((item) => !state.items.contains(item))]
              : [...newItems.where((item) => !state.items.contains(item)), ...state.items],
          lastId: direction == 'down' ? newItems.last['id'] : state.lastId,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
        print("No new data fetched.");
      }
    } catch (e) {
      // Handle errors (e.g., API failure)
      state = state.copyWith(isLoading: false);
      print("Error fetching data: $e");
    }
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }
}

class HomeState {
  final String searchQuery;
  final List<Map<String, dynamic>> items;
  final int lastId;
  final bool isLoading;

  HomeState({
    this.searchQuery = '',
    this.items = const [],
    this.lastId = 50,
    this.isLoading = false,
  });

  HomeState copyWith({
    String? searchQuery,
    List<Map<String, dynamic>>? items,
    int? lastId,
    bool? isLoading,
  }) {
    return HomeState(
      searchQuery: searchQuery ?? this.searchQuery,
      items: items ?? this.items,
      lastId: lastId ?? this.lastId,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  List<Map<String, dynamic>> get filteredItems {
    if (searchQuery.isEmpty) return items;

    return items.where((item) {
      final title = item['title'].toLowerCase();
      final query = searchQuery.toLowerCase();
      return title.contains(query);
    }).toList();
  }
}

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
      (ref) => HomeViewModel(),
);
