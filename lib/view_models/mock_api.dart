// Importing to work with Future and async code
import 'dart:async';

// Function to fetch items based on Id and direction
// Returns a future mapping to data and hasMore value
Future<Map<String, dynamic>> fetchItems({required int id, required String direction}) async {
  // Stimulate a 1- minute delay to mock API calls
  await Future.delayed(Duration(seconds: 1));

  // List to store data
  List<Map<String, dynamic>> data = [];
  // Variable too store if there is more data to be fetched
  bool hasMore = false;

  // Fetch items with Id's greater than id
  if (direction == 'down') {
    for (int i = id + 1; i <= id + 20 && i <= 2000; i++) {
      // Add new items to list
      data.add({'id': i, 'title': 'Item $i'});
    }
    // Check if there are more items to fetch beyond the current range
    hasMore = id + 20 < 2000;
  }
  // Fetch items with Id's less than id
  else if (direction == 'up') {
    for (int i = id - 1; i > 0 && i > id - 20; i--) {
      // Prepend items to maintain order
      data.insert(0, {'id': i, 'title': 'Item $i'});
    }
    // Check if there are more items to fetch beyond the current range
    hasMore = id - 20 > 0;
  }

  // Return fetched items along with hasMore flag
  return {
    'data': data,
    'hasMore': hasMore,
  };
}
