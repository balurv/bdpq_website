import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_data/pages/CreateJobCardPage.dart';
import 'package:form_data/pages/JobCardOpen.dart';
import 'package:form_data/pages/JobStatus.dart';

import 'JobCardPage.dart';
import 'ProfilePage.dart';

class ViewJobCardPage extends StatefulWidget {
  final Map<String, dynamic>? responseData;
  ViewJobCardPage({super.key, this.responseData});

  @override
  _ViewJobCardPage createState() => _ViewJobCardPage(responseData);
}

class _ViewJobCardPage extends State<ViewJobCardPage> {
  final Map<String, dynamic>? responseData;
  _ViewJobCardPage(this.responseData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Job Card'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateJobCardPage(
                        responseData: responseData,
                    ),
                  ),
                );
              },
              child: const Text(
                'Create JobCard',
              ),
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
                    builder: (context) => JobCardOpenPage(
                      responseData: responseData,
                      jobStatus: JobStatus.OPEN
                    ),
                  ),
                );
              },
              child: const Text(
                'Opened',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobCardOpenPage(
                        responseData: responseData,
                        jobStatus: JobStatus.INPROGRESS
                    ),
                  ),
                );
              },
              child: const Text(
                'InProgress',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobCardOpenPage(
                        responseData: responseData,
                        jobStatus: JobStatus.ONHOLD
                    ),
                  ),
                );
              },
              child: const Text(
                'OnHold',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobCardOpenPage(
                        responseData: responseData,
                        jobStatus: JobStatus.COMPLETED
                    ),
                  ),
                );
              },
              child: const Text(
                'Completed',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
