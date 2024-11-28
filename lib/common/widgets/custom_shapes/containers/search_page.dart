import 'package:e_com_app/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchResults = []; // Replace with your product model list.

  void _searchProducts(String query) {
    // Replace with your actual database query logic.
    // Example: Fetch products from your API or database.
    setState(() {
      searchResults = mockDatabase
          .where((product) => product.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EAppBar(
        title: Text('Search Products'), showBackArrow: true,
      ),
      // appBar: AppBar(
      //   title: const Text('Search Products'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search for products',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Iconsax.search_normal),
              ),
              onChanged: _searchProducts,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: searchResults.isEmpty
                  ? const Center(child: Text('No products found'))
                  : ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchResults[index]),
                    onTap: () {
                      // Handle product selection.
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Mock database for demonstration purposes.
final List<String> mockDatabase = [
  'Shoes',
  'Wallet',
  'Glasses',
  'Shirt',
  'Bag',
  'Pants',
];