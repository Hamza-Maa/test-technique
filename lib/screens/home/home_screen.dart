import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/book_controller.dart';
import '../../controllers/bookmarks_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/home/CarouselSlider.dart';
import '../../widgets/home/book_list.dart';
import '../../widgets/home/custom_bottom_navbar.dart';
import '../../widgets/home/shimmer_loading.dart';
import '../bookmarks_screen.dart';
import 'search_screen.dart';

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

  Future<void> _refreshData() async {
    await _bookController.fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    final Widget bodyContent = _selectedIndex == 0
        ? Obx(() {
            if (_bookController.isLoading.value) {
              return const ShimmerLoading();
            } else {
              return RefreshIndicator(
                onRefresh: _refreshData,
                child: SingleChildScrollView(
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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Text(
                              'Books',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.search,
                                  color: AppColors.primaryColor, size: 28),
                              onPressed: () {
                                Get.toNamed('/search');
                              },
                            ),
                          ],
                        ),
                      ),
                      BookList(books: _bookController.filteredBooks),
                    ],
                  ),
                ),
              );
            }
          })
        : const BookmarksScreen();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/img/normal_logo.png',
              height: 40,
              color: AppColors.secondaryColor,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list,
                color: AppColors.primaryColor, size: 28),
            onPressed: () {
              if (_selectedIndex == 0) {
                _bookController.sortBooksByTitle();
              } else if (_selectedIndex == 1) {
                _bookmarksController.sortFavoriteBooksByTitle();
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
