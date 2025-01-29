import 'package:flutter/material.dart';
import 'book_item.dart';

class BookList extends StatelessWidget {
  final List<Map<String, String>> books;

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BookItem(
            imageUrl: book['imageUrl']!,
            author: book['author']!,
            title: book['title']!,
            subtitle: book['subtitle'],
          ),
        );
      },
    );
  }
}
