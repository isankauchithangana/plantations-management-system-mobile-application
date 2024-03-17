import 'package:flutter/material.dart';
import 'package:smartfarm/bdHelper/mongodb.dart'; // Import your MongoDB helper

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Define variables to store user details
  String firstName = '';
  String lastName = '';
  String email = '';
  // Add more fields if needed

  @override
  void initState() {
    super.initState();
    // Fetch user details when the profile page is initialized
    fetchUserDetails();
  }

  // Method to fetch user details from MongoDB
  void fetchUserDetails() async {
    // Get the logged-in user's email from your authentication system
    String loggedInUserEmail = 'user@example.com'; // Replace with your logic

    // Fetch user details based on the email
    await MongoDatabase.connect();
    var user = await MongoDatabase.userCollection.findOne({
      'email': loggedInUserEmail,
    });

    // Update state with user details
    setState(() {
      if (user != null) {
        firstName = user['firstName'] as String;
        lastName = user['lastName'] as String;
        email = user['email'] as String;
        // Update other fields if needed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'First Name: $firstName',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Last Name: $lastName',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 18),
            ),
            // Add more fields if needed
          ],
        ),
      ),
    );
  }
}
