import 'package:flutter/material.dart';
import 'book_item.dart';
import '../../models/book_model.dart';

class BookList extends StatelessWidget {
  final List<Book> books;

  const BookList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: BookItem(
            imageUrl: book.image,
            author: book.authors,
            title: book.title,
            subtitle: book.subtitle,
          ),
        );
      },
    );
  }
}
