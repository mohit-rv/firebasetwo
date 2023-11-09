import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetwo/login2.dart';
import 'package:firebasetwo/phone.dart';
import 'package:firebasetwo/post.dart';
import 'package:firebasetwo/round_button.dart';
import 'package:firebasetwo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool loading = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override      // Dispose is a method triggered whenever the created object from the stateful widget is removed permanently
  void dispose() {   //from the widget tree. It is generally overridden and called only when the state object is destroyed.
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp(){
    setState(() {            //used for loading purpose
      loading = true;         //email passwrd auth throgh firebase
    });
    auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Sign()));
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



  void validate(){
    if(formkey.currentState!.validate()){
        print("ok");
    }else{
      print("Error");
    }
  }


  Future<void> signInWithGoogle()async{      //for logging using google
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleuser =await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =await googleuser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
    );
    final UserCredential userCredential = await auth.signInWithCredential(credential);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       automaticallyImplyLeading: false,
       title: Text('  Signup',
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
                //  SizedBox(height: 60),
                //     Text('Grid',style: TextStyle(color: Colors.blue,fontSize: 40,fontWeight: FontWeight.bold),),
                   SizedBox(height: 70),
                   Padding(
                     padding: const EdgeInsets.only(right: 130),
                     child: Text('SignUp to your account',style: TextStyle(fontSize: 20),),
                   ),






             /*     **************************************************************   */



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
                  title: 'SIGN UP',
                  loading: loading,
                  onTap: (){
                    if(formkey.currentState!.validate()) {
                      signUp();
                    }
                  },
                ),

                /*   Container(height: 30,width: 100,
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
                   SizedBox(height: 20),

               Row(mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('Allready have an account?'),

                   TextButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Sign()));
                   },
                       child: Text('Login'))
                 ],
               ),

               SizedBox(height: 40),
               InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Phone()));
                 },
                 child: Container(height: 50,
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                   border: Border.all(color: Colors.black)),
                   child: Center(
                     child: Text('SignUp with Phone'),
                   ),
                 ),
               ) ,

               SizedBox(height: 20),

                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: ElevatedButton(onPressed: ()

                       async{
                         await signInWithGoogle();
                         if(mounted) {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
                         }
                         },
                           child: Row(mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Image.asset('assets/images/gooogle.png',scale: 42,),
                               Text(' Signup with google',style: TextStyle(fontWeight: FontWeight.bold),),
                             ],
                           ),
                           style: ElevatedButton.styleFrom(primary: Color(0xff002581))),
                   ),

                 ]
               ),
             ),
           ),
         ),
       ),
    );
  }
}
