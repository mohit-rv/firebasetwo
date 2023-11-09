import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetwo/login.dart';
import 'package:firebasetwo/login2.dart';
import 'package:flutter/cupertino.dart';
//import 'package:firebasetwo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {




  Future<void> logout() async{
    final GoogleSignIn googleSign =GoogleSignIn();
    await googleSign.signOut();
    await FirebaseAuth.instance.signOut();
  }

  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
       child: ListView(
         children: [
           DrawerHeader(
               decoration: BoxDecoration(
                 color: Colors.grey
               ),
             child: Column(
               children: [
                  Image.asset('assets/images/Jack.png',scale: 4),
               ],
             ),
           ),

           Column(
             children: [
               ListTile(
                title: Text('Home'),
                 leading: Icon(Icons.home),
                 onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
                 },
               ),

               ListTile(
                 title: Text('Indore'),
                 leading: Icon(Icons.location_city),
               ),
               SizedBox(height: 10),
               Divider(color: Colors.grey,thickness: 2,height: 10,indent: 10,endIndent: 10
               ),
               SizedBox(height: 10),
               ListTile(
                 title: Text('Signup'),
                 leading: Icon(Icons.account_box),
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                 },
               ),

               ListTile(
                 title: Text('Login'),
                 leading: Icon(Icons.login),
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Sign()));
                 },
               ),

               Divider(color: Colors.grey,thickness: 2,height: 20,indent: 10,endIndent: 10),
               SizedBox(height: 30),
               ListTile(
                 title: Text('Logout'),
                 leading: IconButton(onPressed: ()async{
                   await logout();
                   Navigator.push(context, MaterialPageRoute(builder: (context) =>Sign()));

                  // .onError((error, stackTrace){
                  //     Utils().toastMessage(error.toString());
                  //      });
                  },
                 icon: Icon(Icons.logout),)
                  )


             ],
           )
         ],
       ),
      ),



      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30,left: 120),
                  child: Text('WELCOME',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 25),),
                ),

                SizedBox(height: 50),
                 
             /*   SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: TextButton(onPressed: (){

                    Navigator.pushNamed(context, 'login',);
                  },
                      child: Text('Log Out',style: TextStyle(color: Colors.black,fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),)),
                ),   */
                

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
