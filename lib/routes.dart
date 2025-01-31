import 'package:get/get.dart';
import 'screens/authentication/login_screen.dart';
import 'screens/book_details_screen.dart';
import 'screens/bookmarks_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/search_screen.dart';

class Routes {
  static const String start = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String search = '/search';
  static const String bookDetails = '/bookDetails';
  static const String bookMarks = '/bookMarks';

  static final routes = [
    GetPage(name: start, page: () => LoginPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: search, page: () => SearchScreen()),
    GetPage(
      name: bookDetails,
      page: () {
        final arguments = Get.arguments;
        final bookId = arguments['bookId'] as String;
        return BookDetailsScreen(bookId: bookId);
      },
    ),
    GetPage(name: bookMarks, page: () => BookmarksScreen()),
  ];
}