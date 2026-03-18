import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:salakhana_project/View/screens/home.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  Duration get loginTime => const Duration(milliseconds: 2000);

  // Login user
  Future<String?> _authUser(LoginData data) async {
    await Future.delayed(loginTime);

    if (data.name == "rawan@gmail.com" && data.password == "1234") {
      return null; // success
    }
    return "Wrong username or password"; // fail
  }

  // Sign up user
  Future<String?> _signupUser(SignupData data) async {
    await Future.delayed(loginTime);
    return null; // always success for demo
  }

  // Recover password
  Future<String> _recoverPassword(String name) async {
    await Future.delayed(loginTime);
    return "Recovery email sent";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        title: 'Todo App',
        onLogin: _authUser,
        onSignup: _signupUser,
        onRecoverPassword: _recoverPassword,
        onSubmitAnimationCompleted: () {
          // Navigate to Home screen after login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
      ),
    );
  }
}