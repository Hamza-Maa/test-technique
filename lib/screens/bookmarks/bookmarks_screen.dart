import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../controllers/bookmarks_controller.dart';
import '../../widgets/bookDetails/bookMarks_book_list.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookmarksController _bookmarksController = Get.find();

    return Scaffold(
      body: Obx(() {
        if (_bookmarksController.favoriteBooks.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.heart,
                  size: 50,
                  color: Colors.green,
                ),
                SizedBox(height: 8),
                Text(
                  'No favorite books yet!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Bookmarks',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BookMarksList(books: _bookmarksController.favoriteBooks),
              ],
            ),
          );
        }
      }),
    );
  }
}