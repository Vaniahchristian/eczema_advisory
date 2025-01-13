import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static Future<void> initializeFirebase() async {
    try {
      if (kIsWeb) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyCD-n96IV8PkAA5GjZbreEdporOeE-ozP4",
            authDomain: "eczema-4a3c3.firebaseapp.com",
            projectId: "eczema-4a3c3",
            storageBucket: "eczema-4a3c3.firebasestorage.app",
            messagingSenderId: "369279568292",
            appId: "1:369279568292:web:4fb0726568b5fe935b5931",
          ),
        );
      } else {
        await Firebase.initializeApp();
      }
      debugPrint('Firebase initialized successfully');
    } catch (e) {
      debugPrint('Error initializing Firebase: $e');
      rethrow;
    }
  }
}
