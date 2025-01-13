import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Store the auth token
      final String? token = await userCredential.user?.getIdToken();
      if (token != null) {
        await _storage.write(key: 'auth_token', value: token);
      }
      
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Register with email and password
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Send email verification
      await userCredential.user?.sendEmailVerification();
      
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _storage.delete(key: 'auth_token');
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Get auth token
  Future<String?> getAuthToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  // Check if email is verified
  bool get isEmailVerified => currentUser?.emailVerified ?? false;

  // Resend verification email
  Future<void> resendVerificationEmail() async {
    try {
      await currentUser?.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }
}
