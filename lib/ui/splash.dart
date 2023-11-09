import 'package:firebasetwo/ui/services.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  Services Splash = Services();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Splash.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Firebase Auth.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.deepOrange)),
      ),
    );
  }
}
