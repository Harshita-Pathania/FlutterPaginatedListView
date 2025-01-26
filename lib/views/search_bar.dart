// Import Material Package
import 'package:flutter/material.dart';

// Custom search bar widget that notifies parent on change
class CustomSearchBar extends StatefulWidget {
  // Callback function triggered when query updated
  final Function(String) onSearchChanged;

  // Constructor to initialize search bar with callback function
  const CustomSearchBar({super.key, required this.onSearchChanged});

  @override
  State<CustomSearchBar> createState() => _SearchBarState();
}

// State class for managing behaviour and input
class _SearchBarState extends State<CustomSearchBar> {
  // Controller to manage text input field
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // Dispose controller to free up space
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Change values to customize accordingly
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[200],
      child: TextField(
        // Connect controller to text field
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        // Callback function whenever text changes
        onChanged: widget.onSearchChanged,
      ),
    );
  }
}
