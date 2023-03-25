// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/chat_screen.dart';
import './auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  // const AuthScreen({key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  var _isLogin = true;
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    // setState(() {
    //   _isLogin = isLogin;
    // });
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // ChatScreen();
      }
      FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user.uid)
          .set({
        'username': username,
        'emails': email,
      });
      // ChatScreen();
    } on PlatformException catch (error) {
      var massage = 'An error occured, please check your credentials!';
      if (error.message != null) {
        massage = error.message;
      }
      Scaffold.of(ctx).showBottomSheet((context) => Text(massage));
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image:
              AssetImage(_isLogin ? 'assets/login.png' : 'assets/register.png'),
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 130),
                // ignore: prefer_const_constructors
                child: Text(
                  'Welcome\nBlack',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 33,
                  ),
                ),
              ),
              AuthForm(_submitAuthForm, _isLoading),
            ])));
  }
}
