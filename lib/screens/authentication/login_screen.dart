import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/base/custom_button.dart';
import '../../widgets/base/custom_snackbar.dart';
import '../../widgets/base/custom_textfield.dart';
import '../../widgets/base/loading_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserController userController = Get.find<UserController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      final isLoading = userController.isLoading.value;

      return Stack(
        children: [
          Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 200),
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/img/logov1.png',
                              height: 100,
                              color: Colors.green,
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      StyledInputField(
                        controller: emailController,
                        hint: 'Enter your email',
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      StyledInputField(
                        controller: passwordController,
                        hint: 'Enter your password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 80),
                      Center(
                        child: StyledButton(
                          text: 'Login',
                          onPressed: () async {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              showSnackbar("Error, Please fill in all fields.");
                              return;
                            }
                            await userController.login(email, password);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading) const OtpLoadingIndicator(),
        ],
      );
    });
  }
}
