import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_data/pages/WelcomePage.dart';
import '../dto/LoginDto.dart';
import 'package:http/http.dart' as http;

class LoginService {
  final BuildContext context; // Add a field to store the context

  LoginService(
      {required this.context}); // Constructor to initialize the context

  static const String baseUrl = "http://localhost:8080";

  Map<String, dynamic>? responseData;

  Future<void> loginUser(LoginDto loginDto) async {
    final Uri uri = Uri.parse("$baseUrl/api/login");

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(loginDto.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Login successful, you can navigate to the next screen or perform any other actions
        responseData = json.decode(response.body);
        print("Login successful: $responseData");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePage(responseData: responseData),
          ),
        );

        // Navigator.pushNamed(context, '/welcome');
        // MaterialPageRoute(builder: (context) => WelcomePage());
      } else {
        _showLoginFailedDialog(const Text('Invalid Credentials ;(.'));
        // Handle login failure
        print("Login failed");
      }
    } catch (e) {
      // Handle exceptions
      _showLoginFailedDialog(const Text('Server Down'));
      print("Exception: $e");
    }
  }

  void _showLoginFailedDialog(Text text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: text,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the alert box
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
