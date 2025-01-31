import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../widgets/base/custom_snackbar.dart';

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
  //check if user logged in method
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
  //login method
  Future<void> login(String email, String password) async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 3));

      if (email == 'test@gmail.com' && password == 'password') {
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

        showSuccessSnackbar("Logged in successfully!");
        Get.offNamed('/home');
      } else {
        isLoading(false);
        showErrorSnackbar("Invalid email or password. Please try again.");
      }
    } catch (e) {
      isLoading(false);
      showErrorSnackbar("Failed to login, Please try again");
    }
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
