# Two-Way Paginated List View with Riverpod and Mock API Integration

## Overview
This project demonstrates a **two-way paginated list view** built using Flutter. The app integrates:

- **Riverpod** for state management
- **Mock API** for data fetching
- **MVVM (Model-View-ViewModel)** architecture for clean and maintainable code

Key features:
- Two-way pagination (scroll up and down to load more data)
- Search functionality with highlighted results
- Optimized state handling using immutable state updates

## Table of Contents
1. [Concepts Used](#concepts-used)
2. [Architecture](#architecture)
3. [Code Walkthrough](#code-walkthrough)
4. [How to Set Up the Project](#how-to-set-up-the-project)
5. [How to Use the Project](#how-to-use-the-project)
6. [Use Cases](#use-cases)

---

## Concepts Used

### **1. State Management with Riverpod**
Riverpod provides a clean and efficient way to manage app state. It helps separate UI logic from business logic, ensuring maintainability and scalability.

Key Features of Riverpod:
- Dependency injection for better testability
- Compile-time safety
- Immutable state updates

### **2. Immutability and `copyWith` Method**
Immutability ensures state changes do not accidentally affect other parts of the app. The `copyWith` method allows creating a new state instance by updating only specific fields.

Example:
```dart
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
```

### **3. MVVM Architecture**
The MVVM pattern separates UI (View) from business logic (ViewModel), ensuring modularity and testability.

- **Model**: Contains data and logic for fetching/updating it (e.g., API integration).
- **ViewModel**: Holds the app state and exposes data to the UI.
- **View**: UI components that observe changes in the ViewModel.

---

## Architecture

```plaintext
📁 lib/
  |- 📁 models/      # Data structures and API response handling
  |- 📁 viewmodels/  # State management and business logic
  |- 📁 views/       # UI components and widgets
  |- 📁 widgets/     # Reusable UI elements
```

---

## Code Walkthrough

### **1. State Management with `HomeState`**
`HomeState` defines the app's state, including the current search query, fetched items, and loading status.

```dart
class HomeState {
  final String searchQuery;
  final List<Map<String, dynamic>> items;
  final int lastId;
  final bool isLoading;

  HomeState({
    this.searchQuery = '',
    this.items = const [],
    this.lastId = 0,
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
}
```

### **2. Fetching Data with Pagination**
The `loadMoreData` function fetches items when scrolling up or down.

#### Key Logic:
- **Determine fetch direction** (`up` or `down`)
- Fetch data from the mock API
- Append or prepend items to the current state

```dart
Future<void> loadMoreData(String direction) async {
  if (state.isLoading) return;

  int fetchId = direction == 'down' ? state.lastId : state.items.first['id'];
  if ((direction == 'down' && fetchId >= 2000) || (direction == 'up' && fetchId <= 1)) {
    return;
  }

  state = state.copyWith(isLoading: true);
  try {
    var response = await fetchItems(id: fetchId, direction: direction);
    var newItems = response['data'];

    state = state.copyWith(
      items: direction == 'down'
          ? [...state.items, ...newItems]
          : [...newItems, ...state.items],
      lastId: direction == 'down' ? newItems.last['id'] : state.lastId,
      isLoading: false,
    );
  } catch (e) {
    state = state.copyWith(isLoading: false);
    print("Error fetching data: $e");
  }
}
```

---

## How to Set Up the Project

### **Prerequisites**
- Flutter SDK installed
- An IDE (e.g., VS Code, Android Studio)
- Basic knowledge of Dart and Flutter

### **Setup Instructions**
1. Clone the repository:
   ```bash
   git clone <repository_url>
   ```

2. Navigate to the project directory:
   ```bash
   cd two_way_pagination
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## How to Use the Project

1. **Scroll Down**:
   - Fetch and append newer items to the list.
2. **Scroll Up**:
   - Fetch and prepend older items to the list.
3. **Search**:
   - Enter a query in the search bar to filter items. Results will be highlighted.

---

## Use Cases

### **1. Infinite Scrolling**
This pattern is ideal for apps displaying long lists of items, such as:
- Social media feeds
- Product catalogs
- News articles

### **2. Search-Driven Lists**
Efficiently manage and search through large datasets, ensuring smooth user experiences in:
- E-commerce apps
- Library or repository browsers

### **3. Real-Time Updates**
The app can be extended to support real-time updates by integrating WebSocket or similar technologies.

---

## Future Improvements
- Integrate a real backend API
- Add error-handling UI (e.g., retry buttons, error messages)
- Implement caching for offline support

---

## Conclusion
This project showcases a robust, scalable implementation of a two-way paginated list view using Flutter and Riverpod. By leveraging best practices like immutability and MVVM, the app achieves clean separation of concerns, making it easy to maintain and extend.

