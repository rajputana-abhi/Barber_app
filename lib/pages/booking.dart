import 'package:barber_app/Admin/admin_booking.dart';
import 'package:barber_app/pages/home.dart';
import 'package:barber_app/services/database.dart';
import 'package:barber_app/services/shared_prefs.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  String service;
  Booking({required this.service});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? name, image, email;
  getthedatafromsharedprefs() async {
    name = await SharedPrefrences().getUserName();
    image = await SharedPrefrences().getUserImage();
    email = await SharedPrefrences().getUserEmail();
    setState(() {});
  }

  getontheload() async {
    await getthedatafromsharedprefs();
    setState(() {});
  }

  @override
  void initstate() {
    getontheload();
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext Context) async {
    final DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime(2024), lastDate: DateTime(2025));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  TimeOfDay _selectedtime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext Context) async {
    final TimeOfDay? Picked =
        await showTimePicker(context: context, initialTime: _selectedtime);
    if (Picked != null && Picked != _selectedtime) {
      setState(() {
        _selectedtime = Picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b1615),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Let's the \n journey begin",
            style: TextStyle(
                color: Colors.white70,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            child: Image.asset("images/discount.png"),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.service,
            style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Color(0xFFb4817e),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  "Set a Date",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Color(0xFFb4817e),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  "Set a Time",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Icon(
                        Icons.alarm,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "${_selectedtime.format(context)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              Map<String, dynamic> userBookingMap = {
                "service": widget.service,
                "Date":
                    "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"
                        .toString(),
                "Time": _selectedtime.format(context).toString(),
                "name": name,
                "image": image,
                "Email": email
              };
              await DatabaseMethods()
                  .addUserBooking(userBookingMap)
                  .then((value) => {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "Service has been added sucessfully",
                          style: TextStyle(fontSize: 20),
                        )))
                      });
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xFFfe8f33),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  "BOOK NOW",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
