import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // Method to create a user
  Future<User?> createUserWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Set the user's display name after account creation
      await cred.user?.updateDisplayName(username);

      // Save user data locally after account creation
      _saveUserDataLocally(cred.user);

      return cred.user;
    } catch (e) {
      log("Something went wrong: $e");
    }
    return null;
  }

  // Method to login user
  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Save user data locally after login
      _saveUserDataLocally(cred.user);

      return cred.user;
    } catch (e) {
      log("Something went wrong: $e");
    }
    return null;
  }

  // Method to sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();

      // Delete user data from local storage when logged out
      _removeUserDataLocally();
    } catch (e) {
      log("Something went wrong: $e");
    }
  }

  // Save user data locally using SharedPreferences
  Future<void> _saveUserDataLocally(User? user) async {
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', user.uid);
      await prefs.setString('userEmail', user.email ?? '');
      await prefs.setString('userName', user.displayName ?? '');
    }
  }

  // Remove user data from local storage
  Future<void> _removeUserDataLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('userEmail');
    await prefs.remove('userName');
  }

  // Check if a user is already logged in (i.e., check local storage)
  Future<User?> checkIfUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? userEmail = prefs.getString('userEmail');
    String? userName = prefs.getString('userName');

    // If user data exists in local storage, return a mock user
    if (userId != null && userEmail != null && userName != null) {
      User? user = _auth.currentUser;
      if (user != null && user.uid == userId) {
        return user;
      }
    }
    return null; // No user found, or user has logged out
  }

  // Fetch user data from local storage (if needed)
  Future<Map<String, String?>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? userEmail = prefs.getString('userEmail');
    String? userName = prefs.getString('userName');
    return {'userId': userId, 'userEmail': userEmail, 'userName': userName};
  }
}
