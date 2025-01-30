import 'package:get/get.dart';
import '../models/book_model.dart';
import '../services/search_service.dart';

class SearchBookController extends GetxController {
  final SearchService _searchService = SearchService();
  var searchResults = <Book>[].obs;
  var isLoading = false.obs;
  var isSearchExpanded = false.obs;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isLoading(true);
      final results = await _searchService.searchBooks(query);
      searchResults.assignAll(results);
    } catch (e) {
      print('Search Error: $e');
    } finally {
      isLoading(false);
    }
  }

  void toggleSearch() {
    isSearchExpanded.toggle();
    if (!isSearchExpanded.value) {
      searchResults.clear();
    }
  }
}
