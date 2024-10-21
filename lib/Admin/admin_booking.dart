import 'package:barber_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminBooking extends StatefulWidget {
  const AdminBooking({super.key});

  @override
  State<AdminBooking> createState() => _AdminBookingState();
}

class _AdminBookingState extends State<AdminBooking> {
  Stream? BookingStream;
  getontheload() async {
    BookingStream = await DatabaseMethods().getbooking();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allBooking() {
    return StreamBuilder(
        stream: BookingStream,
        builder: (context, Snapshot) {
          return Snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = Snapshot.data.docs(index);
                    return Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xFFB91635),
                              Color(0xFF621d3c),
                              Color(0xFF311937)
                            ]),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    "images/boy.jpg",
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Services: " + ds["Service"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                "Name: " + ds["username"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                "Date: " + ds["date"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                "Time: " + ds["time"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Color(0xFFdf711a),
                                  borderRadius: BorderRadius.circular(20)),
                              child: GestureDetector(
                                onTap: () async {
                                  await DatabaseMethods().deleteBooking(ds.id);
                                },
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 30),
        child: Column(
          children: [
            Center(
              child: Text(
                "All Bookings",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(child: allBooking()),
          ],
        ),
      ),
    );
  }
}
