import 'package:barber_app/pages/home.dart';
import 'package:barber_app/pages/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? mail, pass;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  userlogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail!, password: pass!);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "No user found for that email",
            style: TextStyle(fontSize: 20),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "wrong password",
            style: TextStyle(fontSize: 20),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 30, right: 30),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFB91635),
                Color(0xFF621d3c),
                Color(0xFF311937)
              ])),
              child: Text(
                "Hello,\n Sign in",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 40, left: 30, right: 30),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      "Gmail",
                      style: TextStyle(
                          color: Color(0xFFB91635),
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a Email";
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          hintText: "Gmail",
                          prefixIcon: Icon(Icons.mail_outline)),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                          color: Color(0xFFB91635),
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Password";
                        }
                        return null;
                      },
                      controller: passcontroller,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password_outlined)),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget Password ?",
                          style: TextStyle(
                              color: Color(0xFF621d3c),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            mail = emailcontroller.text;
                            pass = passcontroller.text;
                          });
                          userlogin();
                        }
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(colors: [
                                Color(0xFFB91635),
                                Color(0xFF621d3c),
                                Color(0xFF311937)
                              ])),
                          child: Center(
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Don't have a account ?",
                        style: TextStyle(
                            color: Color(0xFF621d3c),
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text("SIGN UP",
                          style: TextStyle(
                              color: Color(0xFF621d3c),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
