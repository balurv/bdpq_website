
import 'package:flutter/material.dart';
import 'package:form_data/dto/LoginDto.dart';
import 'package:form_data/service/LoginService.dart';
import 'CompanyLogoText.dart';
import 'ForgotPasswordPage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginService loginService = LoginService(context: context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CompanyLogoText(buttonText: 'bdpq'),
            SizedBox(
              width: 5,
            ),
            Text('Login Page'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final loginDto = LoginDto(
                  username: usernameController.text,
                  password: passwordController.text,
                );
                loginService.loginUser(loginDto);
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                // Navigate to the forgot password page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                );
              },
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
