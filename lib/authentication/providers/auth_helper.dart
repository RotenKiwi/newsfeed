import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  get user => auth.currentUser;

  Future<String> register({required String email,required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message??'Failure';
    }
  }

  Future<String> signIn({required String email,required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message??'Failure';
    }
  }

  Future signOut() async {
    await auth.signOut();
  }
}