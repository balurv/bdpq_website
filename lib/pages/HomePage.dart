import 'package:flutter/material.dart';

import 'CompanyLogoText.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('Company'),
            Text('')
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'FARM MACHINERY RENTALS!',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('SIGN UP'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('LOG IN'),
            ),
          ],
        ),
      ),
    );
  }
}
