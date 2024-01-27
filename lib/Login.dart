import 'package:flutter/material.dart';
import 'package:smartfarm/bdHelper/mongodb.dart';
import 'package:smartfarm/cultivation_page.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'SmartFarm',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 5, 5, 5),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo2.png', // Replace with the path to your logo asset
              width: 100, // Adjust the size as needed
              height: 100, // Adjust the size as needed
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(44.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: emailController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 67, 235, 90),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        child: Text("Login"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: _navigateToRegister,
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: const Color.fromRGBO(33, 150, 243, 1),
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    // Validate email and password
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    // Check for empty fields
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "Email and password are required.";
      });
      return;
    }

    // Additional validation checks (e.g., email and password format)
    if (isValidEmail(email) && isValidPassword(password)) {
      // Set error message for invalid email or password
      setState(() {
        errorMessage = "Valid email or password";
      });
      return;
    }

    // Check if the user exists in MongoDB
    final bool isValidUser = await MongoDatabase.validateUser(email, password);

    if (isValidUser) {
      // User is valid, perform login actions
      print("Login successful");

      // Fetch the user's first name from the database based on the email
      final String firstName = await MongoDatabase.getUserFirstName(email);

      // Navigate to the CultivationPage and pass the user's name
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CultivationPage(userName: firstName),
        ),
      );
    } else {
      // User is not valid, show an error message
      setState(() {
        errorMessage = "Invalid email or password";
      });
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    return regex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final RegExp regex = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");
    return regex.hasMatch(password);
  }
}
