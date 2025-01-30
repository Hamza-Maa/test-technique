import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/book_controller.dart';
import '../../controllers/bookmarks_controller.dart';
import '../../widgets/home/CarouselSlider.dart';
import '../../widgets/home/book_list.dart';
import '../../widgets/home/custom_bottom_navbar.dart';
import '../../widgets/home/shimmer_loading.dart';
import '../bookmarks/bookmarksScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookController _bookController = Get.put(BookController());
  final BookmarksController _bookmarksController =
      Get.put(BookmarksController());
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget bodyContent = _selectedIndex == 0
        ? Obx(() {
            if (_bookController.isLoading.value) {
              return const ShimmerLoading();
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Highlights',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CarouselWidget(books: _bookController.books),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Books',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BookList(books: _bookController.filteredBooks)
                  ],
                ),
              );
            }
          })
        : const BookmarksScreen();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/img/logov1.png',
              height: 40,
              color: Colors.green,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.green, size: 28),
            onPressed: () {
              if (_selectedIndex == 0) {
                _bookController.sortBooksByTitle();
              } else if (_selectedIndex == 1) {
                _bookmarksController
                    .sortFavoriteBooksByTitle();
              }
            },
          ),
        ],
      ),
      body: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        body: bodyContent,
      ),
    );
  }
}
