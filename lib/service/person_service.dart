import 'dart:convert';
import 'package:flutter/material.dart';

import '../dto/PersonDto.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class PersonService{
  static const String baseUrl = "http://localhost:8080";

  Future<void> savePerson(PersonDto personDto) async {
    final Uri uri = Uri.parse("$baseUrl/api/signup");

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(personDto.toJson()),
      );

      if (response.statusCode == 201|| response.statusCode == 200) {
        // Successfully created
        // print("Person saved successfully");
        Fluttertoast.showToast(
          msg: "Person saved successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        // Handle other response statuses
        // print("Failed to save person. Status code: ${response.statusCode}");
        // print("Response body: ${response.body}");
        Fluttertoast.showToast(
          msg: "Failed to save person:${response.body}. Status code: ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (error) {
      // Handle network errors
      // print("Error during the HTTP request: $error");
      Fluttertoast.showToast(
        msg: "Error during the HTTP request: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}