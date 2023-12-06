import 'package:firebase_core/firebase_core.dart';

FirebaseOptions get firebaseOptions => const FirebaseOptions(
      apiKey: 'YOUR_API_KEY',
      appId: 'YOUR_APP_ID',
      messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
      projectId: 'YOUR_PROJECT_ID',
      databaseURL: 'YOUR_DATABASE_URL',
    );
