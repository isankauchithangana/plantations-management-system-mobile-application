import 'package:flutter/material.dart';
import 'package:smartfarm/bdHelper/mongodb.dart';
import 'Login.dart';
import 'cultivation_page.dart'; // Import the CultivationPage

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var addressController = TextEditingController();

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: fnameController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "First Name",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextField(
                        controller: lnameController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextField(
                        controller: emailController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextField(
                        controller: addressController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Address",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: _insertData,
                            child: Text("Register"),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 74, 163, 236),
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

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  void _insertData() async {
    // Get the values from controllers
    String firstName = fnameController.text;
    String lastName = lnameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String address = addressController.text;

    // Check if any field is empty
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        address.isEmpty) {
      // Show an error message if any field is empty
      _showErrorMessage("All fields are required.");
      return;
    }

    // Insert data into MongoDB using the helper function
    await MongoDatabase.insertData(
      firstName,
      lastName,
      email,
      password,
      address,
    );

    // After successful registration, navigate to the CultivationPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CultivationPage(
            userName: "John"), // Replace "John" with the actual user's name
      ),
    );
  }

  void _showErrorMessage(String message) {
    // Show a simple dialog with the error message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
