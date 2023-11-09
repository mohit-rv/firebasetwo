import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetwo/otp.dart';
import 'package:firebasetwo/round_button.dart';
import 'package:firebasetwo/utils/utils.dart';
import 'package:flutter/material.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
             SizedBox(height: 50),
            TextFormField(
             // keyboardType: TextInputType.number,
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: '+1 234 4333 879',),
            ),
            SizedBox(height: 50),
            
            RoundButton(title: 'SignUp',loading: loading, onTap: (){

              setState(() {
                loading = true;
              });

              auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){
                  setState(() {
                    loading = false;
                  });
                  },

                  verificationFailed: (e){
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(e.toString());
                  },

                  codeSent: (String verificationId , int? token){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Otp(verificationId: verificationId,)));
                  setState(() {
                    loading = false;
                  });  },

                  codeAutoRetrievalTimeout: (e){
                  Utils().toastMessage(e.toString());
                  setState(() {
                    loading = false;
                  });
                  }  // codeAutoRetrievalTimeout
                  ); //auth.verifyPhoneNumber
            })


          ],
        ),
      ),
    );
  }
}
