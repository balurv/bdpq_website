import 'package:flutter/material.dart';

class CompanyLogoText extends StatelessWidget {
  final String buttonText;

  const CompanyLogoText({Key? key, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/');
      },
      child: Text(buttonText),
    );
  }
}
