import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<HomeScreen> {
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await userController.logout();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text("Welcome to the Homepage!"),
      ),
    );
  }
}
