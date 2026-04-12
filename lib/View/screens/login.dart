import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:salakhana_project/View/screens/main_nav.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Duration get loginTime => const Duration(milliseconds: 2000);

  // =========================
  // STORED USER EMAIL
  // =========================
  String userEmail = "";

  // =========================
  // LOGIN FUNCTION
  // =========================
  Future<String?> _authUser(LoginData data) async {
    await Future.delayed(loginTime);

    // Simple demo login
    if (data.name == "rawan@gmail.com" && data.password == "1234") {
      userEmail = data.name; // save logged-in email
      return null; // success
    }

    return "Wrong username or password";
  }

  // =========================
  // SIGNUP (DEMO ONLY)
  // =========================
  Future<String?> _signupUser(SignupData data) async {
    await Future.delayed(loginTime);
    return null;
  }

  // =========================
  // PASSWORD RECOVERY
  // =========================
  Future<String> _recoverPassword(String name) async {
    await Future.delayed(loginTime);
    return "Recovery email sent";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        title: 'Todo App',

        // =========================
        // THEME (optional styling)
        // =========================
        theme: LoginTheme(
          primaryColor: Colors.purple,
          accentColor: Colors.purpleAccent,
          errorColor: Colors.red,
          titleStyle: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),

        // =========================
        // AUTH CALLBACKS
        // =========================
        onLogin: _authUser,
        onSignup: _signupUser,
        onRecoverPassword: _recoverPassword,

        // =========================
        // AFTER SUCCESS LOGIN
        // =========================
        onSubmitAnimationCompleted: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainNav(userEmail: userEmail),
            ),
          );
        },
      ),
    );
  }
}