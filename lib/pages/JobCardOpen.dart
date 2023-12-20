import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'JobStatus.dart';

// enum JobStatus { OPEN, INPROGRESS, ONHOLD, RESUME, COMPLETED }

class JobCardOpenPage extends StatefulWidget {
  final Map<String, dynamic>? responseData;
  final JobStatus? jobStatus;
  const JobCardOpenPage({super.key, this.responseData, this.jobStatus});

  @override
  _JobCardOpenPageState createState() =>
      _JobCardOpenPageState(responseData, jobStatus);
}

class _JobCardOpenPageState extends State<JobCardOpenPage> {
  final Map<String, dynamic>? responseData;
  final JobStatus? jobStatus;

  _JobCardOpenPageState(this.responseData, this.jobStatus);
  TextEditingController farmerIdController = TextEditingController();
  late Future<List<dynamic>> jobCardList;

  @override
  void initState() {
    super.initState();
    jobCardList = getJobCard();
    print('Hiii balu!');
  }

  Future<List<dynamic>> getJobCard() async {
    final response = await http.get(
      Uri.parse(
          'http://localhost:8080/jobcard/status?'
              'jobStatus=${jobStatus.toString().split('.').last}&farmerId=${responseData!['id']}'),
    );

    if (response.statusCode == 200) {
      print('hello sir ${response.body}');
      final jsonResponse = json.decode(response.body);
      final List<dynamic> jobCards = jsonResponse['content'];
      return jobCards;
    } else {
      print(response.body);
      throw Exception('Failed to load job card');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Card Page'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: jobCardList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<dynamic> jobCards = snapshot.data!;
            return ListView.builder(
              itemCount: jobCards.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Job ID: ${jobCards[index]['id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Field: ${jobCards[index]['farmFields'][0]['name']}',
                      ),
                      Text(
                        'Machinery:${jobCards[index]['machineryType']}',
                      ),
                      Text('Estimated cost :${jobCards[index]['estimatedPayment']}')
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
