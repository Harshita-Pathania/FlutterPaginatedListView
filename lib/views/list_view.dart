import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class list_view extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Future<void> Function() onLoadMoreUp;
  final Future<void> Function() onLoadMoreDown;
  final bool isLoading;
  final String searchQuery;

  const list_view({
    Key? key,
    required this.items,
    required this.onLoadMoreUp,
    required this.onLoadMoreDown,
    required this.isLoading,
    required this.searchQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo is ScrollUpdateNotification && !isLoading) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            onLoadMoreDown();
          } else if (scrollInfo.metrics.pixels == scrollInfo.metrics.minScrollExtent) {
            onLoadMoreUp();
          }
        }
        return true;
      },
      child: ListView.builder(
        itemCount: items.isEmpty ? 1 : items.length + (isLoading ? 5 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (isLoading) {
            return _buildShimmerPlaceholder();
          }

          if (items.isEmpty) {
            return Center(child: Text('No results found.'));
          }

          return _buildListItem(items[index], searchQuery);
        },
      ),
    );
  }

  Widget _buildListItem(Map<String, dynamic> item, String searchQuery) {
    final title = item['title'] ?? '';

    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE25E36).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.laptop_chromebook_outlined),
        title: _highlightText(title, searchQuery),
        trailing: Icon(Icons.download_for_offline_outlined),
      ),
    );
  }

  Widget _highlightText(String text, String searchQuery) {
    if (searchQuery.isEmpty) {
      return Text(text);
    }

    final parts = <TextSpan>[];
    final queryLower = searchQuery.toLowerCase();
    int start = 0;

    while (true) {
      final index = text.toLowerCase().indexOf(queryLower, start);
      if (index == -1) {
        parts.add(TextSpan(text: text.substring(start)));
        break;
      }
      if (index > start) {
        parts.add(TextSpan(text: text.substring(start, index)));
      }
      parts.add(TextSpan(
        text: text.substring(index, index + searchQuery.length),
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ));
      start = index + searchQuery.length;
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: parts,
      ),
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.all(5.0),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
