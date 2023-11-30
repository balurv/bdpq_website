import 'package:flutter/material.dart';
import 'package:form_data/pages/FarmerFieldPage.dart';

import 'ProfilePage.dart';

class WelcomePage extends StatelessWidget {
  final Map<String, dynamic>? responseData;

  const WelcomePage({Key? key, this.responseData}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text('bdpq'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FarmerFieldPge(responseData: responseData),
                  ),
                );
                // Navigator.pushNamed(context, '/farmerfileds');
              },
              child: const Text('View farm field'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Response Data: $responseData');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(responseData: responseData),
                  ),
                );
              },
              child: const Text('Go to profile'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('Go to settings'),
            ),
          ],
        ),
      ),
    );
  }
}
