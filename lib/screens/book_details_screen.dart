import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/book_details_controller.dart';
import '../controllers/bookmarks_controller.dart';
import '../models/book_model.dart';
import '../widgets/bookDetails/book_details_content.dart';
import '../widgets/bookDetails/bookDetails_shimmer_loading.dart';
import '../widgets/bookDetails/book_details_error.dart';

class BookDetailsScreen extends StatelessWidget {
  final String bookId;

  const BookDetailsScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final BookDetailsController _bookDetailsController =
        Get.put(BookDetailsController());
    final BookmarksController _bookmarksController = Get.find();

    _bookDetailsController.fetchBookDetails(bookId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (_bookDetailsController.isLoading.value) {
          return const BookDeatilsShimmerLoading();
        } else if (_bookDetailsController.bookDetails.value == null) {
          return BookDetailsErrorWidget(
            onRetry: () => _bookDetailsController.fetchBookDetails(bookId),
          );
        } else {
          final book = _bookDetailsController.bookDetails.value!;
          final bookForFavorites = Book(
            id: book.id,
            title: book.title,
            subtitle: book.subtitle,
            authors: book.authors,
            image: book.image,
            url: book.url,
          );

          return BookDetailsContent(
            book: book,
            bookForFavorites: bookForFavorites,
            bookmarksController: _bookmarksController,
            bookDetailsController: _bookDetailsController,
          );
        }
      }),
    );
  }
}
