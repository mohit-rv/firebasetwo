import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetwo/post.dart';
import 'package:firebasetwo/round_button.dart';
import 'package:firebasetwo/utils/utils.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  final String verificationId;
  const Otp({Key? key, required this.verificationId}) : super(key: key);


  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  bool loading = false;
  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: verificationCodeController,
              decoration: InputDecoration(
                hintText: '6 digit code',),
            ),
            SizedBox(height: 50),

            RoundButton(title: 'Verify',loading: loading, onTap: () async{

              setState(() {
                loading = true;
              });

              final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verificationCodeController.text.toString()
              );

              try{
                await auth.signInWithCredential(credential);

                Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));

              }catch(e){
                setState(() {
                  loading = false;
                });
                Utils().toastMessage(e.toString());
              }
            })


          ],
        ),
      ),
    );
  }
}
