import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/book_model.dart';

class BookmarksController extends GetxController {
  final RxList<Book> favoriteBooks = <Book>[].obs;
  var isAscendingOrder = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoriteBooks();
  }

  Future<void> loadFavoriteBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteBooksJson =
        prefs.getStringList('favoriteBooks');

    if (favoriteBooksJson != null) {
      favoriteBooks.assignAll(
        favoriteBooksJson.map((json) {
          final Map<String, dynamic> bookMap = jsonDecode(json);
          return Book.fromJson(bookMap);
        }).toList(),
      );
    }
  }

  Future<void> _saveFavoriteBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteBooksJson = favoriteBooks.map((book) {
      return jsonEncode(book.toJson());
    }).toList();
    await prefs.setStringList('favoriteBooks', favoriteBooksJson);
  }

  void addToFavorites(Book book) {
    if (!favoriteBooks.contains(book)) {
      favoriteBooks.add(book);
      _saveFavoriteBooks();
    }
  }

  void removeFromFavorites(Book book) {
    favoriteBooks.remove(book);
    _saveFavoriteBooks();
  }

  bool isFavorite(Book book) {
    return favoriteBooks.contains(book);
  }

  void sortFavoriteBooksByTitle() {
    final sortedBooks = List<Book>.from(favoriteBooks);
    if (isAscendingOrder.value) {
      sortedBooks.sort((a, b) => a.title.compareTo(b.title));
    } else {
      sortedBooks.sort((a, b) => b.title.compareTo(a.title));
    }
    favoriteBooks.assignAll(sortedBooks);
    isAscendingOrder.toggle();
  }
}
