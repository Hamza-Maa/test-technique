import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/book_details_controller.dart';
import '../controllers/bookmarks_controller.dart';
import '../models/book_model.dart';
import '../utils/colors.dart';
import '../widgets/base/custom_button.dart';
import '../widgets/base/custom_snackbar.dart';
import '../widgets/bookDetails/bookDetails_shimmer_loading.dart';
import '../widgets/bookDetails/book_details_error.dart';
import 'package:http/http.dart' as http;

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
            onRetry: () {
              _bookDetailsController.fetchBookDetails(bookId);
            },
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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      book.image,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        book.authors,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                    Obx(() {
                      final isFavorite =
                          _bookmarksController.isFavorite(bookForFavorites);
                      return GestureDetector(
                        onTap: () {
                          if (isFavorite) {
                            _bookmarksController
                                .removeFromFavorites(bookForFavorites);
                          } else {
                            _bookmarksController
                                .addToFavorites(bookForFavorites);
                          }
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Icon(
                            isFavorite
                                ? Icons.bookmark_outlined
                                : Icons.bookmark_outline,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  book.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (book.subtitle.isNotEmpty)
                  Text(
                    book.subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  book.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                StyledButton(
                  onPressed: () async {
                    final downloadUrl = book.download;
                    try {
                      final response = await http.head(Uri.parse(downloadUrl));

                      if (response.statusCode == 200) {
                        if (await canLaunch(downloadUrl)) {
                          await launch(downloadUrl);
                        } else {
                          showErrorSnackbar("Unable to open the browser.");
                        }
                      } else {
                        showErrorSnackbar("Download link is not available.");
                      }
                    } catch (e) {
                      showErrorSnackbar("Failed to check the download link.");
                    }
                  },
                  text: 'Download',
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
