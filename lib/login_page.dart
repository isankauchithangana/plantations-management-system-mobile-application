// login_page.dart

import 'package:flutter/material.dart';
import 'StartingPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Perform login logic here
                // For simplicity, let's check if both fields are not empty
                if (_usernameController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  // Navigate to the starting page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StartingPage(),
                    ),
                  );
                } else {
                  // Show an error message or handle invalid login
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Invalid Login'),
                      content: Text('Please enter valid credentials.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
