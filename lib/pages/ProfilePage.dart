import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic>? responseData;

  const ProfilePage({Key? key, this.responseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Profile Page Response Data: $responseData');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This is the Profile Page!',
              style: TextStyle(fontSize: 20),
            ),
            if (responseData != null)
              Column(
                children: [
                  Text(
                    'Username: ${responseData!['name']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Email: ${responseData!['email']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  // Add more fields as needed
                ],
              ),
          ],
        ),
      ),
    );
  }
}
