import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/user_controller.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
      initialRoute:
          userController.user.value.token != null ? '/home' : '/login',
    );
  }
}
