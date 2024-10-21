import 'package:barber_app/Admin/admin_booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              "Admin Panel",
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "UserName",
                      style: TextStyle(
                          color: Color(0xFFB91635),
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      hintText: "UserName",
                      prefixIcon: Icon(Icons.person_2_outlined)),
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
                TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.mail_outline)),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    loginAdmin();
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
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance
        .collection("Admin")
        .get()
        .then((snapshot) => snapshot.docs.forEach((result) {
              if (result.data()["username"] != namecontroller.text.trim()) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  "Wrong username",
                  style: TextStyle(fontSize: 20),
                )));
              } else if (result.data()["password"] !=
                  emailcontroller.text.trim()) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  "Wrong Password",
                  style: TextStyle(fontSize: 20),
                )));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminBooking()));
              }
            }));
  }
}
