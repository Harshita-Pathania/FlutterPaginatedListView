// Importing RiverPod for state management
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Importing the mock API
import '../models/mock_api.dart';

// ViewModel to handel Stateful functions using StateNotifier
class HomeViewModel extends StateNotifier<HomeState> {
  // Constructor to load initial data on start
  HomeViewModel() : super(HomeState()) {
    _loadInitialData();
  }

  // Method to load initial data
  Future<void> _loadInitialData() async {
    // Setting isLoading to true to display shimmer effect
    state = state.copyWith(isLoading: true);

    try {
      // Fetching data from mock API
      var response = await fetchItems(id: state.lastId, direction: 'down');
      // Updating states
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

  // Method to load more data on scrolling up or down
  Future<void> loadMoreData(String direction) async {
    if (state.isLoading) return; // Avoid multiple requests at once

    // Determine Id based on scroll direction
    int fetchId = direction == 'down' ? state.lastId : state.items.first['id'];

    // Check boundaries to prevent calls
    if ((direction == 'down' && fetchId >= 2000) ||
        (direction == 'up' && fetchId <= 1)) {
      print("No more data to fetch.");
      return;
    }

    // Set isLoading to true before fetching data
    state = state.copyWith(isLoading: true);

    try {
      // Fetching data
      var response = await fetchItems(id: fetchId, direction: direction);
      var newItems = response['data'];

      // Check if data is returned
      if (newItems.isNotEmpty) {
        // Append or prepend data based on scroll direction and stop loading
        state = state.copyWith(
          items: direction == 'down'
              ? [...state.items, ...newItems.where((item) => !state.items.contains(item))]
              : [...newItems.where((item) => !state.items.contains(item)), ...state.items],
          lastId: direction == 'down' ? newItems.last['id'] : state.lastId,
          isLoading: false,
        );
      } else {
        // Stop loading if data not fetched
        state = state.copyWith(isLoading: false);
        print("No new data fetched.");
      }
    } catch (e) {
      // Handle errors (e.g., API failure)
      state = state.copyWith(isLoading: false);
      print("Error fetching data: $e");
    }
  }

  // Method to update searchQuery state
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }
}

// State class to represent data of home page
class HomeState {
  final String searchQuery;
  final List<Map<String, dynamic>> items;
  final int lastId;
  final bool isLoading;

  // Constructor with default values for initial fetch
  HomeState({
    this.searchQuery = '',
    this.items = const [],
    this.lastId = 50,
    this.isLoading = false,
  });

  // Method to create new state object by copying original state and updating specific fields
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

  // Getter to returned filtered list of items
  List<Map<String, dynamic>> get filteredItems {
    if (searchQuery.isEmpty) return items;

    // Filter to return matching titles
    return items.where((item) {
      final title = item['title'].toLowerCase();
      final query = searchQuery.toLowerCase();
      return title.contains(query);
    }).toList();
  }
}

// Provider to make ViewModel accessible to other parts and UI
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
      (ref) => HomeViewModel(),
);
