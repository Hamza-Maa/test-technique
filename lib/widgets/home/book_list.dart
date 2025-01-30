import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'book_item.dart';
import '../../models/book_model.dart';
import '../../controllers/book_controller.dart';

class BookList extends StatelessWidget {
  final List<Book> books;

  const BookList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    final BookController _bookController = Get.find();

    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _bookController.filteredBooks.length,
        itemBuilder: (context, index) {
          final book = _bookController.filteredBooks[index];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: BookItem(book: book),
          );
        },
      );
    });
  }
}
