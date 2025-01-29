// lib/widgets/home/CarouselSlider.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/book_model.dart';
import 'CarouselItem.dart';

class CarouselWidget extends StatelessWidget {
  final List<Book> books;

  const CarouselWidget({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: books.map((book) {
        return CarouselItemWidget(
          item: {
            'imageUrl': book.image,
            'author': book.authors,
            'title': book.title,
            'subtitle': book.subtitle,
          },
        );
      }).toList(),
    );
  }
}
