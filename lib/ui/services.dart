import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetwo/login.dart';
import 'package:firebasetwo/post.dart';
import 'package:flutter/material.dart';

class Services{


  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(Duration(seconds: 3),
              () => {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Post()))
          });
    }else{
      Timer(Duration(seconds: 3),
              () => {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()))
          });
    }
  }



}