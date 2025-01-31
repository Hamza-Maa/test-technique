import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book_details_model.dart';
import '../services/book_details_service.dart';

class BookDetailsController extends GetxController {
  final BookDetailsService _bookDetailsService = BookDetailsService();
  final Rx<BookDetails?> bookDetails = Rx<BookDetails?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isDownloading = false.obs;

  void setDownloading(bool value) {
    isDownloading.value = value;
  }

  Future<void> loadCachedBookDetails(String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedBookDetailsJson =
        prefs.getString('cachedBookDetails_$bookId');

    if (cachedBookDetailsJson != null) {
      final Map<String, dynamic> cachedBookDetailsMap =
          jsonDecode(cachedBookDetailsJson);
      bookDetails(BookDetails.fromJson(cachedBookDetailsMap));
    }
  }

  Future<void> _cacheBookDetails(BookDetails bookDetails) async {
    final prefs = await SharedPreferences.getInstance();
    final String cachedBookDetailsJson = jsonEncode(bookDetails.toJson());
    await prefs.setString(
        'cachedBookDetails_${bookDetails.id}', cachedBookDetailsJson);
  }

  Future<void> fetchBookDetails(String bookId) async {
    try {
      isLoading(true);
      final details = await _bookDetailsService.fetchBookDetails(bookId);
      bookDetails(details);
      await _cacheBookDetails(details);
    } catch (e) {
      await loadCachedBookDetails(bookId);
    } finally {
      isLoading(false);
    }
  }
}
