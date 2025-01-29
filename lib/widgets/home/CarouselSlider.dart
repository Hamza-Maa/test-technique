import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'CarouselItem.dart';

class CarouselWidget extends StatelessWidget {
  final List<Map<String, String>> carouselItems = [
    {
      'imageUrl': 'assets/img/logov1.png',
      'author': 'Douglas Adams',
      'title': 'Beginning Excel 2019',
      'subtitle': 'Learn Excel from Scratch',
    },
    {
      'imageUrl': 'assets/img/logov1.png',
      'author': 'Panagiotis',
      'title': 'The Economics of Big Science',
      'subtitle': 'Essays by Leading Scientists and Policymakers',
    },
    {
      'imageUrl': 'assets/img/logov1.png',
      'author': 'Robert W. Maloy',
      'title': 'Building Democracy for All',
    },
  ];

  CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: carouselItems.map((item) {
        return CarouselItemWidget(item: item);
      }).toList(),
    );
  }
}
