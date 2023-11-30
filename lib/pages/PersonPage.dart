import 'package:flutter/material.dart';
import 'package:form_data/service/person_service.dart';
import '../dto/PersonDto.dart';
import 'CompanyLogoText.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final PersonService apiService = PersonService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CompanyLogoText(buttonText: 'bdpq'),
            SizedBox(
              width: 5,
            ),
            Text('Farmer Sign up'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  // Add logic for unique name validation if needed
                  return null;
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value.length != 10) {
                    return 'Phone number should be 10 digits';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(
                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password should be greater than 6 characters';
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already user?'),
                  const SizedBox(
                    width: 3,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('LOG IN'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final personDto = PersonDto(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        apiService.savePerson(personDto);
                      }
                    },
                    child: const Text('Save Person'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
