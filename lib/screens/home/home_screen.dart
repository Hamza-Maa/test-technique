import 'package:flutter/material.dart';
import '../../widgets/home/CarouselSlider.dart';
import '../../widgets/home/book_list.dart';
import '../../widgets/home/custom_bottom_navbar.dart';
import '../bookmarks/bookmarksScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget bodyContent = _selectedIndex == 0
        ? SingleChildScrollView(
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
                CarouselWidget(),
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
                BookList(books: [
                  {
                    'imageUrl': 'assets/img/logov1.png',
                    'author': 'Panagiotis',
                    'title': 'The Economics of Big Science',
                    'subtitle': 'Essays by Leading Scientists and Policymakers',
                  },
                  {
                    'imageUrl': 'assets/img/logov1.png',
                    'author': 'Noreen Brown',
                    'title': 'Beginning Excel 2019',
                  },
                  {
                    'imageUrl': 'assets/img/logov1.png',
                    'author': 'Noreen Brown',
                    'title': 'Beginning Excel 2019',
                  },
                ]),
              ],
            ),
          )
        : BookmarksScreen();

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
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Handle filter icon press
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
