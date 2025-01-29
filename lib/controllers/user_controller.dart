import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  var user = User(id: '', name: '', email: '').obs;

  var isLoading = false.obs;

  late SharedPreferences _prefs;

  final Random _random = Random();

  @override
  void onInit() {
    super.onInit();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() {
    final token = _prefs.getString('token');
    if (token != null) {
      user.value = User(
        id: _prefs.getString('id') ?? '',
        name: _prefs.getString('name') ?? '',
        email: _prefs.getString('email') ?? '',
        token: token,
      );
      Get.offNamed('/home');
    }
  }

  // Login method
  Future<void> login(String email, String password) async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 3));
      final token = _generateRandomToken();
      final loggedInUser = User(
        id: '1',
        name: 'User',
        email: email,
        token: token,
      );

      await _prefs.setString('id', loggedInUser.id);
      await _prefs.setString('name', loggedInUser.name);
      await _prefs.setString('email', loggedInUser.email);
      await _prefs.setString('token', loggedInUser.token!);

      user.value = loggedInUser;
      isLoading(false);

      Get.snackbar('Success', 'Logged in successfully!');
      Get.offNamed('/home');
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', 'Failed to login: $e');
    }
  }

  Future<void> logout() async {
    await _prefs.clear();
    user.value = User(id: '', name: '', email: '');
    Get.offNamed('/login');
  }

  String _generateRandomToken() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(
      32,
      (_) => chars.codeUnitAt(_random.nextInt(chars.length)),
    ));
  }
}
