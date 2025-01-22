import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:sensors_plus/sensors_plus.dart';

import 'add_Contact.dart';
import 'graph_page.dart';

class DataPoint {
  final int x;
  final double y;

  DataPoint(this.x, this.y);
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double speed = 0;
  List<DataPoint> _xData = List<DataPoint>.empty(growable: true);
  List<DataPoint> _yData = List<DataPoint>.empty(growable: true);
  List<DataPoint> _zData = List<DataPoint>.empty(growable: true);
  Location _location = Location();
  StreamSubscription<LocationData>? _locationStreamSubscription;

  Location location = Location();
  String emai = "";
  String aliass = "";
  List help = [];
  double long = 0;
  double lang = 0;

  dialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Mail Sent Successfully'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  sendEmail(
      {required String name,
        required String email,
        required String subject,
        required String long,
        required String lang}) async {
    final service_id = 'service_i1na6ju';
    final template_id = 'template_71zw56f';
    final user_id = 'uwD1BVUdnVVYEHaQv';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': service_id,
        'template_id': template_id,
        'user_id': user_id,
        'template_params': {
          'user_name': name,
          'long': long,
          'lang': lang,
          'to_name':  '',
          'from_name': 'Furquan',
          'to_email': email,
          'user_subject': subject,
        },
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _xData.add(DataPoint(_xData.length, event.x));
        _yData.add(DataPoint(_yData.length, event.y));
        _zData.add(DataPoint(_zData.length, event.z));
        if (event.x > 10 && event.y > 10 && event.z > 10) {
          print("Send email");
          sendEmail(
              name: "Aadya",
              email: "aadyagaur6@gmail.com",
              lang: lang.toString(),
              long: long.toString(),
              subject: 'Someone close of your had an accident');
          dialog();
        }
      });
    });
    _locationStreamSubscription =
        _location.onLocationChanged.listen((LocationData locationData) {
          print(locationData.speed);
          setState(() {
            speed = locationData.speed ?? 0;
            long = locationData.longitude!;
            lang = locationData.latitude!;
          });
        });

    Timer.periodic(Duration(seconds: 60), (Timer t) {
      // get the current timestamp
      final now = DateTime.now().millisecondsSinceEpoch;

      // remove elements from the x-axis data array
      while (_xData.isNotEmpty && now - _xData.first.x > 90000) {
        _xData.removeAt(0);
      }

      // remove elements from the y-axis data array
      while (_yData.isNotEmpty && now - _yData.first.x > 90000) {
        _yData.removeAt(0);
      }

      // remove elements from the z-axis data array
      while (_zData.isNotEmpty && now - _zData.first.x > 90000) {
        _zData.removeAt(0);
      }
    });

    // sendEmail(name: "Guneet", email: "guneetsinghtuli@Gmail.com", subject: "Check", message: "Chal gaya BC");
    getLocation();
  }

  @override
  void dispose() {
    // Stop monitoring the location stream
    _locationStreamSubscription?.cancel();
    super.dispose();
  }

  changeStateAlias(String email, String alias) {
    help.add({'email': email, 'alias': alias});
  }

  changeStateEmail() {}
  submit() {}

  getLocation() async {
    print("Location");
    LocationData currentLocation = await location.getLocation();
    setState(() {
      speed = currentLocation.speed!;
    });
  }

  getLongLang() async {
    LocationData currentLocation = await location.getLocation();
    List ans = [currentLocation.longitude, currentLocation.latitude];
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Don't Suffer",
                        style: GoogleFonts.poppins(
                            fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.help))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(0, 232, 152, 1),
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "You are currently",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ),
                          Container(
                            child: const Icon(
                              Icons.motorcycle_rounded,
                              color: Colors.white,
                              size: 27,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "On Foot",
                        style: GoogleFonts.montserrat(),
                      )
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,

                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AddContact(change: changeStateAlias)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Your current speed " + speed.truncateToDouble().toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AddContact(change: changeStateAlias)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Add Contacts for SOS",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(9))),
                  child: Column(
                    children: [
                      // ListView.builder(itemBuilder: (BuildContext context))
                      Card(
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Furquan",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "guneetsinghtuli@Gmail.com",
                                      style: GoogleFonts.poppins(fontSize: 11),
                                    )
                                  ],
                                ),
                                Icon(Icons.delete)
                              ],
                            )),
                      ),
                      Card(
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Aadya",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "guneetsinghtuli@Gmail.com",
                                      style: GoogleFonts.poppins(fontSize: 11),
                                    )
                                  ],
                                ),
                                Icon(Icons.delete)
                              ],
                            )),
                      ),
                      Card(
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Geetisha",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "guneetsinghtuli@Gmail.com",
                                      style: GoogleFonts.poppins(fontSize: 11),
                                    )
                                  ],
                                ),
                                Icon(Icons.delete)
                              ],
                            )),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromRGBO(0, 232, 152, 1),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.home_filled)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Graph()));
                          },
                          icon: const Icon(Icons.graphic_eq)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}