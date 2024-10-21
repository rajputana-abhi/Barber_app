import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String? email;
  TextEditingController mail = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  resetpassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Email send Sucessfully",
          style: TextStyle(fontSize: 20),
        ),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == "usernot-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "NO user found",
          style: TextStyle(fontSize: 20),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                "PasswordRecovery",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text("Enter your mail",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.white60,
                        size: 30,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  setState(() {
                    email = mail.text;
                  });
                  resetpassword();
                }
              },
              child: Text(
                "Send Email",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
