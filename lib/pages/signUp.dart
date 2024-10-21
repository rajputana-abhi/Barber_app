import 'package:barber_app/pages/home.dart';
import 'package:barber_app/pages/login.dart';
import 'package:barber_app/services/database.dart';
import 'package:barber_app/services/shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name, mail, pass;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (pass != null && name != null && mail != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail!, password: pass!);
        String id = randomAlphaNumeric(10);
        await SharedPrefrences().saveUserName(namecontroller.text);
        await SharedPrefrences().saveUserEmail(emailcontroller.text);
        await SharedPrefrences().saveUserImages("");
        await SharedPrefrences().saveUserId(id);
        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "Email": emailcontroller.text,
          "Id": id,
          "Image": "image",
        };
        await DatabaseMethods().addUserDetails(userInfoMap, id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Register sucessful",
            style: TextStyle(fontSize: 20),
          ),
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "week password",
              style: TextStyle(fontSize: 20),
            ),
          ));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Account already exists",
              style: TextStyle(fontSize: 20),
            ),
          ));
        }
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
                "Create a Account",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              color: Color(0xFFB91635),
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter name";
                        }
                        return null;
                      },
                      controller: namecontroller,
                      decoration: InputDecoration(
                          hintText: "Name",
                          prefixIcon: Icon(Icons.person_2_outlined)),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Gmail",
                          style: TextStyle(
                              color: Color(0xFFB91635),
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Email";
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: TextStyle(
                              color: Color(0xFFB91635),
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
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
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            name = namecontroller.text;
                            mail = emailcontroller.text;
                            pass = passcontroller.text;
                          });
                        }
                        registration();
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
                              "SIGN UP",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Already have an account ?",
                            style: TextStyle(
                                color: Color(0xFF621d3c),
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("SIGN IN",
                              style: TextStyle(
                                  color: Color(0xFF621d3c),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
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
