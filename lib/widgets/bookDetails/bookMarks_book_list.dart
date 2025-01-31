import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/book_model.dart';
import '../home/book_item.dart';

class BookMarksList extends StatelessWidget {
  final List<Book> books;

  const BookMarksList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: BookItem(book: book),
          );
        },
      );
    });
  }
}