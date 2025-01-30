import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../controllers/search_book_controller.dart';
import '../../widgets/home/book_list.dart';
import '../widgets/empty_state_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchBookController _searchController =
      Get.put(SearchBookController());
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Search Books",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: "Search books...",
                hintStyle: TextStyle(color: Colors.grey.shade500),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon:
                    const Icon(Iconsax.search_normal, color: Colors.green),
                suffixIcon: _textEditingController.text.isNotEmpty
                    ? IconButton(
                        icon:
                            const Icon(Iconsax.close_circle, color: Colors.red),
                        onPressed: () {
                          _textEditingController.clear();
                          _searchController.searchResults.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (query) {
                _searchController.search(query);
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Obx(() {
                if (_searchController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (_textEditingController.text.isEmpty) {
                  return EmptyStateWidget(
                    icon: Iconsax.search_normal,
                    title: "Start Searching",
                    subtitle: "Find your favorite books by entering a title.",
                  );
                } else if (_searchController.searchResults.isEmpty) {
                  return EmptyStateWidget(
                    icon: Iconsax.box_remove,
                    title: "No Results Found",
                    subtitle: "Try searching with different keywords.",
                  );
                }
                return BookList(books: _searchController.searchResults);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
