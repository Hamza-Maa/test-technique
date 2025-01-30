import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/bookmarks_controller.dart';
import '../../models/book_model.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final BookmarksController _bookmarksController = Get.find();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Image
              Image.network(
                book.image,
                width: 80,
                height: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.authors,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Title
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Favorite Icon
              Obx(() {
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
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
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
          const SizedBox(height: 8),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 80,
            endIndent: 0,
            height: 0,
          ),
        ],
      ),
    );
  }
}
