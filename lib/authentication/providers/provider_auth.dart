import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth_helper.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  bool loading = false;

  changeStatus() {
    loading = !loading;
    notifyListeners();
  }

  AuthenticationHelper authHelper = AuthenticationHelper();

  Future<Map> signIn() async {
    changeStatus();
    if (validateEmail(emailTextController.text)) {
      changeStatus();
      return {"status": "failure", "reason": "Invalid email-id"};
    }
    if (validatePassword() != "") {
      changeStatus();
      return {"status": "failure", "reason": validatePassword()};
    }

    String response = await authHelper.signIn(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim());
    changeStatus();
    if (response == "Success") {
      return {"status": "success"};
    } else {
      return {"status": "failure", "reason": "Incorrect Credentials"};
    }
  }

  Future<Map> signUpUser() async {
    changeStatus();
    if (validateEmail(emailTextController.text)) {
      changeStatus();
      return {"status": "failure", "reason": "Invalid email-id"};
    }
    if (validatePassword() != "") {
      changeStatus();
      return {"status": "failure", "reason": validatePassword()};
    }
    if (validateName() != "") {
      changeStatus();
      return {"status": "failure", "reason": validateName()};
    }

    String response = await authHelper.register(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim());
    changeStatus();
    if (response == "Success") {
      try {
        FirebaseFirestore.instance.collection('user').add({
          'name': nameTextController.text.trim(),
          'email': emailTextController.text.trim(),
        });
      } catch (e) {
        print("Exception: $e");
      }
      return {"status": "success"};
    } else {
      return {"status": "failure", "reason": response};
    }
  }

  signOut() {
    nameTextController.clear();
    emailTextController.clear();
    passwordTextController.clear();
    authHelper.signOut();
  }

  String validateName() {
    if (nameTextController.text.isEmpty) {
      return "Name can't be empty";
    } else {
      return "";
    }
  }

  String validatePassword() {
    if (passwordTextController.text.isEmpty) {
      return "Password can't be empty";
    } else if (passwordTextController.text.length < 8) {
      return "Minimum 8 characters long password required";
    } else {
      return "";
    }
  }

  bool validateEmail(String email) {
    final RegExp emailRegExp = RegExp(r'^([a-zA-Z0-9]+)([\-_.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$');
    return emailRegExp.hasMatch(email);
  }
}
