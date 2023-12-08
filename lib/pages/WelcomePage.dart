import 'package:flutter/material.dart';
import 'package:form_data/pages/FarmerFieldPage.dart';
import 'package:form_data/pages/JobCardPage.dart';
import 'package:form_data/pages/ViewJobCardPage.dart';

import 'CreateJobCardPage.dart';
import 'ProfilePage.dart';

class WelcomePage extends StatelessWidget {
  final Map<String, dynamic>? responseData;

  const WelcomePage({Key? key, this.responseData}) : super(key: key);

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
                    builder: (context) =>
                        FarmerFieldPge(responseData: responseData),
                  ),
                );
                // Navigator.pushNamed(context, '/farmerfileds');
              },
              child: const Text('My FarmField'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             CreateJobCardPage(responseData: responseData),
            //       ),
            //     );
            //   },
            //   child: const Text('My JobCard'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        // JobCardPage(responseData: responseData,),
                        ViewJobCardPage(
                      responseData: responseData,
                    ),
                  ),
                );
              },
              child: const Text('My JobCard'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Response Data: $responseData');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfilePage(responseData: responseData),
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
