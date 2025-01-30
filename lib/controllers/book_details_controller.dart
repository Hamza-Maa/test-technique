import 'package:get/get.dart';
import '../models/book_details_model.dart';
import '../services/book_details_service.dart';

class BookDetailsController extends GetxController {
  final BookDetailsService _bookDetailsService = BookDetailsService();
  final Rx<BookDetails?> bookDetails = Rx<BookDetails?>(null);
  final RxBool isLoading = true.obs;

  Future<void> fetchBookDetails(String bookId) async {
    try {
      isLoading(true);
      final details = await _bookDetailsService.fetchBookDetails(bookId);
      bookDetails(details);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load book details: $e');
    } finally {
      isLoading(false);
    }
  }
}
