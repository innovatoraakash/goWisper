import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homePage.dart';
// import 'package:flutter_session/flutter_session.dart';

// const users = const {
//   'aakash@gmail.com': '12345',
//   'manish@gmail.com': 'hunter',
//   'x@x.x': 'xyz',
//   '1': '1'
// };
final _auth = FirebaseAuth.instance;
String email = '';
String password = '';

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 1250);

  Future<String> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: data.name, password: data.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      } else {
        return (e.message);
      }
    } catch (e) {
      return (e);
    }
  }

  Future<String> _signupUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );

      SnackBar(
        content: Text('Sucessfully Register.You Can Login Now'),
        duration: Duration(seconds: 5),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        return (e.message);
      }
    } catch (e) {
      return (e);
    }
  }

  Future<String> _recoverPassword(String name) async {
    print('Name: $name');
    try {
      await _auth.sendPasswordResetEmail(email: name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else {
        return (e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'goWisper',
      // logo: Icon(Icons.message),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        _auth.authStateChanges().listen((User user) {
          if (user != null) {
            // FlutterSession().set("token", data.name);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
          }
        });
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
