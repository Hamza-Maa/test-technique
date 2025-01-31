import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/bookmarks_controller.dart';
import '../../models/book_model.dart';
import '../../routes.dart';
import '../../screens/book_details_screen.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';

class CarouselItemWidget extends StatelessWidget {
  final Book book;

  const CarouselItemWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final BookmarksController _bookmarksController = Get.find();

    return GestureDetector(
      onTap: () {
        String sanitizedBookId = sanitizeBookId(book.id);
        Get.toNamed(Routes.bookDetails, arguments: {'bookId': sanitizedBookId});
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                book.image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        book.authors,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Obx(() {
                      final isFavorite = _bookmarksController.isFavorite(book);
                      return GestureDetector(
                        onTap: () {
                          if (isFavorite) {
                            _bookmarksController.removeFromFavorites(book);
                          } else {
                            _bookmarksController.addToFavorites(book);
                          }
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          child: Icon(
                            isFavorite ? Icons.bookmark : Icons.bookmark_border,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      );
                    }),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          book.subtitle,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
