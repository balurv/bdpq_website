import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'FarmerFieldPage.dart';

class CreateFarmFieldPage extends StatefulWidget {
  Map<String, dynamic>? responseData;
  CreateFarmFieldPage({Key? key, this.responseData}) : super(key: key);

  @override
  _CreateFarmFieldPageState createState() =>
      _CreateFarmFieldPageState(responseData: responseData);
}
enum SoilType { RED_SOIL, BLACK_SOIL, ALLUVIAL_SOIL, LATERITE_SOIL, MOUNTAIN_SOIL, DESERT_SOIL, COASTAL_SOIL }

class _CreateFarmFieldPageState extends State<CreateFarmFieldPage> {
  Map<String, dynamic>? responseData;
  SoilType? selectedSoilType;

  _CreateFarmFieldPageState({this.responseData});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController breadthController = TextEditingController();

  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  // Function to get the current device location
  void _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  int soilTypeToInt(SoilType soilType) {
    return soilType.index;
  }

  // Function to handle the form submission
  void _submitForm() async {
    // Replace the URL with your backend API endpoint
    const String apiUrl = 'http://localhost:8080/person';
    int farmerId = responseData!['id']; // Replace with the actual farmerId

    // Prepare the farm field data
    Map<String, dynamic> farmFieldData = {
      'name': nameController.text,
      'length': double.parse(lengthController.text),
      'breath': double.parse(breadthController.text),
      'latitude': latitude,
      'totalArea': double.parse(lengthController.text) *
          double.parse(breadthController.text),
      'longitude': longitude,
      'owner': responseData!['farmFields'],
      'soilType': selectedSoilType != null ? soilTypeToInt(selectedSoilType!) : null,
    };

    // Send a PATCH request to update the farm field
    final http.Response response = await http.patch(
      Uri.parse('$apiUrl/$farmerId/farmfield'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(farmFieldData),
    );

    if (response.statusCode == 200) {
      // Farm field updated successfully
      // You can handle the success scenario here
      // print('Farm field updated successfully');
      _showAlertDialog('Success', 'Farm field updated successfully');
      _clearFormData();
    } else {
      // Error in updating farm field
      // You can handle the error scenario here
      // print('Failed to update farm field. Status code: ${response.statusCode}');
      _showAlertDialog('Error', 'Failed to update farm field. Status code: ${response.statusCode}');

    }

  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _clearFormData() {
    // Clear form data here
    nameController.clear();
    lengthController.clear();
    breadthController.clear();
    setState(() {
      selectedSoilType = null;
    });
  }

  // Function to open external maps with the current location
  void _openMaps() async {
    String url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch maps');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Farm Field'),
        actions: [
          BackButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FarmerFieldPge(responseData: responseData),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Field Name'),
            ),
            TextField(
              controller: lengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Field Length'),
            ),
            TextField(
              controller: breadthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Field Breadth'),
            ),
            DropdownButton<SoilType>(
              hint: Text('Select Soil Type'),
              value: selectedSoilType,
              onChanged: (SoilType? value) {
                setState(() {
                  selectedSoilType = value;
                });
              },
              items: SoilType.values.map((SoilType type) {
                return DropdownMenuItem<SoilType>(
                  value: type,
                  child: Text(type.toString().split('.').last),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            Text('Latitude: $latitude, Longitude: $longitude'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _getLocation,
              child: const Text('Update Location'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
