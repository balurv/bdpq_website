import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_data/pages/CreateFarmField.dart';
import 'package:http/http.dart' as http;
import '../dto/FarmerField.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmerFieldPge extends StatelessWidget {
  final Map<String, dynamic>? responseData;

  const FarmerFieldPge({Key? key, this.responseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreateFarmFieldPage(responseData: responseData),
                  ),
                );
                // Navigator.pushNamed(context, '/farmerfileds');
              },
              child: const Text('Create Farm field'),
            ),
            const Text('Farm Fields'),
          ],
        ),
      ),
      body: FutureBuilder(
        future: responseData != null
            ? fetchFarmFields(responseData!['id'])
            : Future.value([]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<FarmField> farmFields = (snapshot.data as List<FarmField>);
            return ListView.builder(
              itemCount: farmFields.length,
              itemBuilder: (context, index) {
                FarmField farmField = farmFields[index];
                return Card(
                  child: ListTile(
                    title: Text('Name: ${farmField.name}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${farmField.id}'),
                        // Text('Latitude: ${farmField.latitude}'),
                        // Text('Longitude: ${farmField.longitude}'),
                        Text('Length: ${farmField.length}'),
                        Text('Breath: ${farmField.breath}'),
                        Text('Total Area: ${farmField.totalArea}'),
                        Text('Soil Type: ${farmField.soilType}'),
                        ElevatedButton(
                            onPressed: () {
                              _viewOnMaps(context, farmField.latitude,
                                  farmField.longitude);
                            },
                            child: const Text('view on maps'))
                        // Add other fields as needed
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<FarmField>> fetchFarmFields(int personId) async {
    final response = await http.get(
        Uri.parse('http://localhost:8080/person/farmfield?personId=$personId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print('response body ${response.body}');
      List<FarmField> farmFields = data
          .map((item) => FarmField.fromJson(item as Map<String, dynamic>))
          .toList();
      return farmFields;
    } else {
      throw Exception('Failed to load farm fields');
    }
  }

  Future<void> _viewOnMaps(BuildContext context, double latitude, double longitude) async {
    // Construct the Google Maps URL with the given latitude and longitude
    String mapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    // Check if the URL can be launched
    if (await canLaunch(mapsUrl)) {
      // Launch the Google Maps URL
      await launch(mapsUrl, forceSafariVC: false, forceWebView: true);
    } else {
      // Handle the case where the URL cannot be launched
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open Google Maps'),
        ),
      );
    }
  }
}
