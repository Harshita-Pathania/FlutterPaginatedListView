import 'dart:async';

Future<Map<String, dynamic>> fetchItems({required int id, required String direction}) async {
  await Future.delayed(Duration(seconds: 1));

  List<Map<String, dynamic>> data = [];
  bool hasMore = false;

  if (direction == 'down') {
    for (int i = id + 1; i <= id + 20 && i <= 2000; i++) {
      data.add({'id': i, 'title': 'Item $i'});
    }
    hasMore = id + 20 < 2000;
  } else if (direction == 'up') {
    for (int i = id - 1; i > 0 && i > id - 20; i--) {
      data.insert(0, {'id': i, 'title': 'Item $i'});
    }
    hasMore = id - 20 > 0;
  }

  return {
    'data': data,
    'hasMore': hasMore,
  };
}
