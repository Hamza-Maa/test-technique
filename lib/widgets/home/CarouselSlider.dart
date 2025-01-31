import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/book_model.dart';
import 'CarouselItem.dart';

class CarouselWidget extends StatelessWidget {
  final List<Book> books;

  const CarouselWidget({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    final limitedBooks = books.length > 3 ? books.sublist(0, 3) : books;

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: limitedBooks.map((book) {
        return CarouselItemWidget(book: book);
      }).toList(),
    );
  }
}
