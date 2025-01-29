import 'package:get/get.dart';
import '../models/book_model.dart';
import '../services/book_service.dart';

class BookController extends GetxController {
  final BookService _bookService = BookService();
  var books = <Book>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchBooks();
    super.onInit();
  }

  Future<void> fetchBooks() async {
    try {
      isLoading(true);
      final response = await _bookService.fetchBooks();
      books.assignAll(response.books);
    } catch (e) {
      print('Error fetching books: $e');
    } finally {
      isLoading(false);
    }
  }
}
