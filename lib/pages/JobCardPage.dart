import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CreateJobCardPage.dart';

class JobCardPage extends StatefulWidget {
  final Map<String, dynamic>? responseData;

  const JobCardPage({super.key, this.responseData});

  @override
  _JobCardPageState createState() => _JobCardPageState(responseData);
}

class _JobCardPageState extends State<JobCardPage> {
  late Future<List<dynamic>> jobCardList;
  final Map<String, dynamic>? responseData;
  _JobCardPageState(this.responseData);

  @override
  void initState() {
    super.initState();
    jobCardList = fetchJobCard(responseData!['id']);
  }

  Future<List<dynamic>> fetchJobCard(int farmerId) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/jobcard/farmer/$farmerId'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load job card');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Farmer Job Card Page',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreateJobCardPage(responseData: responseData),
                  ),
                );
              },
              child: const Text('Create JobCard'),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: jobCardList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> jobCards = snapshot.data!;
            return ListView.builder(
              itemCount: jobCards.length,
              itemBuilder: (context, index) {
                // Customize this part based on your JobCard model
                return ListTile(
                  title: Text('Job ID: ${jobCards[index]['id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Field: ${jobCards[index]['farmFields']}',
                      ),
                      Text(
                        'Machinery:${jobCards[index]['machineryType']}',
                      ),
                    ],
                  ),
                  // Add more details as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
