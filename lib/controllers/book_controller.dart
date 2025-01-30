import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book_model.dart';
import '../services/book_service.dart';
import '../widgets/base/custom_snackbar.dart';

class BookController extends GetxController {
  final BookService _bookService = BookService();
  var books = <Book>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    loadCachedBooks();
    fetchBooks();
    super.onInit();
  }

  Future<void> loadCachedBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedBooksJson = prefs.getString('cachedBooks');

    if (cachedBooksJson != null) {
      final List<dynamic> cachedBooksList = jsonDecode(cachedBooksJson);
      books.assignAll(
        cachedBooksList.map((bookJson) => Book.fromJson(bookJson)).toList(),
      );
    }
  }

  Future<void> _cacheBooks(List<Book> books) async {
    final prefs = await SharedPreferences.getInstance();
    final String cachedBooksJson =
        jsonEncode(books.map((book) => book.toJson()).toList());
    await prefs.setString('cachedBooks', cachedBooksJson);
  }

  Future<void> fetchBooks() async {
    try {
      isLoading(true);
      final response = await _bookService.fetchBooks();
      books.assignAll(response.books);
      await _cacheBooks(response.books);
    } catch (e) {
      showErrorSnackbar("Connection error, Please verify your internet");
    } finally {
      isLoading(false);
    }
  }
}
