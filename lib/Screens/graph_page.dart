import 'dart:async';

import 'package:syncfusion_flutter_charts/charts.dart';

import './home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {

  List<DataPoint> _xData = List<DataPoint>.empty(growable: true);
  List<DataPoint> _yData = List<DataPoint>.empty(growable: true);
  List<DataPoint> _zData = List<DataPoint>.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _xData.add(DataPoint(_xData.length, event.x));
        _yData.add(DataPoint(_yData.length, event.y));
        _zData.add(DataPoint(_zData.length, event.z));
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

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    padding: EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Accelerometer",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Center(
                    child: SfCartesianChart(),
                  //   child: SfCartesianChart(
                  //     primaryXAxis: NumericAxis(),
                  //     series: <LineSeries<DataPoint, int>>[
                  //       LineSeries<DataPoint, int>(
                  //         dataSource: _xData,
                  //         xValueMapper: (DataPoint point, _) => point.x,
                  //         yValueMapper: (DataPoint point, _) => point.y,
                  //         name: 'X',
                  //       ),
                  //       LineSeries<DataPoint, int>(
                  //         dataSource: _yData,
                  //         xValueMapper: (DataPoint point, _) => point.x,
                  //         yValueMapper: (DataPoint point, _) => point.y,
                  //         name: 'Y',
                  //       ),
                  //       LineSeries<DataPoint, int>(
                  //         dataSource: _zData,
                  //         xValueMapper: (DataPoint point, _) => point.x,
                  //         yValueMapper: (DataPoint point, _) => point.y,
                  //         name: 'Z',
                  //       ),
                  //     ],
                  //   ),
                  ),
                ]),
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }, icon: Icon(Icons.home_filled)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                      IconButton(
                          onPressed: () {

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

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

class DataPoint {
  final int x;
  final double y;

  DataPoint(this.x, this.y);
}