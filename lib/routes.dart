import 'package:get/get.dart';
import 'screens/authentication/login_screen.dart';
import 'screens/home/home_screen.dart';

class Routes {

  static const String start = '/';
  static const String login = '/login';
  static const String home = '/home';

  static final routes = [
    GetPage(name: start, page: () => LoginPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: home, page: () => HomeScreen()),
  ];
}
