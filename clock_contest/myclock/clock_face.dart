import 'package:flutter/material.dart';
import 'clock_dial.dart';
import 'clock_hands.dart';

class ClockFace extends StatelessWidget {
  final DateTime dateTime;

  ClockFace({this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Stack(
            children: <Widget>[
              //dial and numbers
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(5.0),
                child: CustomPaint(
                  painter: ClockDial(),
                ),
              ),
              ClockHands(dateTime: dateTime),
            ],
          ),
        ),
      ),
    );
  }
}
