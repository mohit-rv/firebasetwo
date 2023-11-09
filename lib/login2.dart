

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetwo/login.dart';
import 'package:firebasetwo/post.dart';
import 'package:firebasetwo/round_button.dart';
import 'package:firebasetwo/utils/utils.dart';
import 'package:flutter/material.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {

  bool loading = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    auth.signInWithEmailAndPassword(email: emailController.text,
        password: passwordController.text.toString()).then((value){
          // Utils().toastMessage(value.user!.email.toString());
           Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    });
  }



  void validate(){
    if(formkey.currentState!.validate()){
      print("ok");
    }else{
      print("Error");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
           title: Text('               Login',
           style: TextStyle(color: Colors.white),),
           backgroundColor: Colors.deepPurple,
         ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                /*  SizedBox(height: 60),
                  Text('Grid',style: TextStyle(color: Colors.blue,fontSize: 40,fontWeight: FontWeight.bold),),  */
                  SizedBox(height: 120),
                  Padding(
                    padding: const EdgeInsets.only(right: 130),
                    child: Text('Login to your account',style: TextStyle(fontSize: 20),),
                  ),

                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder( borderRadius: BorderRadius.circular(1)),
                        prefixIcon: Icon(Icons.mail)),
                    validator: (val){
                      if (val!.isEmpty){
                        return 'Required';
                      }if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val)){
                        return 'please Enter a valid mail';
                      }else{
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: 30,),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: "password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                        prefixIcon: Icon(Icons.lock)),
                    validator: (val){
                      if(val!.isEmpty){
                        return "Required";
                      }else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30),

                  RoundButton(
                    title: 'LOGIN',
                    loading: loading,
                    onTap: (){
                      if(formkey.currentState!.validate()) {
                        login();
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  Row(    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () {
                        Navigator.pushNamed(context, 'otp');
                      },
                        child: Text('FORGOT PASSWORD',style: TextStyle(decoration: TextDecoration.underline),),),
                      
                      
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                        child: Text('SIGN UP',style: TextStyle(decoration: TextDecoration.underline),),)

                    ],
                  ),

    /*    Container(height: 30,width: 100,
                     child: ElevatedButton(onPressed: validate,
                         child: Text('Login',style: TextStyle(color: Colors.white),),
                         style: ElevatedButton.styleFrom(primary: Color(0xff002581)),

                     ),
                   ),  */

                  /*   Container(color: Colors.blue,width: 100,
                     child: TextButton(onPressed: () {
                       if(formkey.currentState!.validate()){
                         setState(() {
                           loading = true;
                         });
                         auth.createUserWithEmailAndPassword(
                             email: emailController.text.toString(),
                             password: passwordController.text.toString()).then((value){
                           setState(() {
                             loading = false;
                           });
                         }).onError((error, stackTrace){
                           Utils().toastMessage(error.toString());
                           setState(() {
                             loading = false;
                           });
                         });
                       }
                     },
                         child: Text('Sign up',style: TextStyle(color: Colors.white),),),
                   ),   */



                  /*  SizedBox(height: 30),
               Row(    mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   TextButton(onPressed: () {
                     Navigator.pushNamed(context, 'otp');
                   },
                  child: Text('FORGOT PASSWORD',style: TextStyle(decoration: TextDecoration.underline),),)

                 ],
               ),    */



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
