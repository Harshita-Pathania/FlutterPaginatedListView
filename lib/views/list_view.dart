// Import Material package and shimmer package for animation
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Custom ListView widget that supports loading on scrolling
class list_view extends StatelessWidget {
  // List of items to display
  final List<Map<String, dynamic>> items;
  // Functions to load more data
  final Future<void> Function() onLoadMoreUp;
  final Future<void> Function() onLoadMoreDown;
  // Flag to check if loading
  final bool isLoading;
  // String to hold user searchQuery
  final String searchQuery;

  // Constructor to initialize values
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
      // Detects scrolling to load more data
      onNotification: (scrollInfo) {
        if (scrollInfo is ScrollUpdateNotification && !isLoading) {
          // Check if scrolled to bottom
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            onLoadMoreDown();
          }
          // Check if scrolled to top
          else if (scrollInfo.metrics.pixels == scrollInfo.metrics.minScrollExtent) {
            onLoadMoreUp();
          }
        }
        // Continue receiving notifications
        return true;
      },
      child: ListView.builder(
        // Set item count to include shimmer if loading
        itemCount: items.isEmpty ? 1 : items.length + (isLoading ? 5 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (isLoading) {
            // Show shimmer placeholder during loading
            return _buildShimmerPlaceholder();
          }

          if (items.isEmpty) {
            // Return text if no items found
            return Center(child: Text('No results found.'));
          }

          // Build individual list items
          return _buildListItem(items[index], searchQuery);
        },
      ),
    );
  }

  // Method to create ListItem
  Widget _buildListItem(Map<String, dynamic> item, String searchQuery) {
    // Get item's title
    final title = item['title'] ?? '';

    return Container(
      // Change value to customize accordingly
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

  // Method to return highlighted matching text
  Widget _highlightText(String text, String searchQuery) {
    if (searchQuery.isEmpty) {
      // Return plain text if no matching text found
      return Text(text);
    }

    final parts = <TextSpan>[];
    // Case insensitive comparison
    final queryLower = searchQuery.toLowerCase();
    int start = 0;

    while (true) {
      final index = text.toLowerCase().indexOf(queryLower, start);
      if (index == -1) {
        // Add remaining if no matching text found
        parts.add(TextSpan(text: text.substring(start)));
        break;
      }
      if (index > start) {
        // Add unmatched text
        parts.add(TextSpan(text: text.substring(start, index)));
      }
      parts.add(TextSpan(
        // Add matching text with style
        text: text.substring(index, index + searchQuery.length),
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ));
      start = index + searchQuery.length;
    }

    return RichText(
      text: TextSpan(
        // Default text style
        style: TextStyle(color: Colors.black),
        // Combined text
        children: parts,
      ),
    );
  }

  // Method to create shimmer placeholders
  Widget _buildShimmerPlaceholder() {
    // Change values to customize accordingly
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
