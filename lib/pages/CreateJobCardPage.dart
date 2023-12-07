import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum MachineryType {
  TRACTOR,
  CAR,
  BIKE,
  TRACTOR_ROTAVATOR,
  TRACTOR_CULTIVATOR,
  TRACTOR_ROUND_STRAW_BALER,
  TRACTOR_PADDY_HARVEST,
}
class CreateJobCardPage extends StatefulWidget {
  final Map<String, dynamic>? responseData;

  const CreateJobCardPage({super.key, this.responseData});

  @override
  _CreateJobCardPageState createState() => _CreateJobCardPageState();
}

class _CreateJobCardPageState extends State<CreateJobCardPage> {
  TextEditingController farmFieldIdController = TextEditingController();
  MachineryType selectedMachineryType = MachineryType.TRACTOR;

  List<MachineryType> machineryTypes = [
    MachineryType.TRACTOR,
    MachineryType.CAR,
    MachineryType.BIKE,
    MachineryType.TRACTOR_ROTAVATOR,
    MachineryType.TRACTOR_CULTIVATOR,
    MachineryType.TRACTOR_ROUND_STRAW_BALER,
    MachineryType.TRACTOR_PADDY_HARVEST,
  ];

  Future<void> createJobCard() async {
    const String apiUrl = 'http://localhost:8080/jobcard'; // Replace with your actual API URL

    final Map<String, dynamic> requestData = {
      'farmFieldId': int.parse(farmFieldIdController.text),
      'machinery': selectedMachineryType.toString().split('.').last,
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 201) {
      print('Job card created successfully');
      // Handle success, e.g., navigate to another screen or show a success message
    } else {
      print('Failed to create job card. Error ${response.statusCode}: ${response.body}');
      // Handle error, e.g., show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Job Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: farmFieldIdController,
              decoration: const InputDecoration(labelText: 'Farm Field ID'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButton<MachineryType>(
              value: selectedMachineryType,
              onChanged: (MachineryType? newValue) {
                setState(() {
                  selectedMachineryType = newValue!;
                });
              },
              items: machineryTypes.map<DropdownMenuItem<MachineryType>>(
                    (MachineryType value) {
                  return DropdownMenuItem<MachineryType>(
                    value: value,
                    child: Text(value.toString()),
                  );
                },
              ).toList(),
              hint: const Text('Select Machinery Type'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: createJobCard,
              child: const Text('Create Job Card'),
            ),
          ],
        ),
      ),
    );
  }
}
