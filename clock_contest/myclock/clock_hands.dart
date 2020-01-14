//import 'dart:async';

import 'package:flutter/material.dart';

import 'package:vector_math/vector_math_64.dart' show radians;
import 'drawn_hand.dart';

/// Total distance traveled by a second or a minute hand, each second or minute, respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

class ClockHands extends StatelessWidget {
  final DateTime dateTime;

  ClockHands({this.dateTime});

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: 1.0,
      child: new Container(
        width: double.infinity,
        //padding: const EdgeInsets.all(20.0),
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            DrawnHand(
              color: Colors.grey,
              thickness: 5, // zm 16,
              size: 0.5,
              angleRadians: dateTime.hour * radiansPerHour +
                  (dateTime.minute / 60) * radiansPerHour,
            ),
            DrawnHand(
              color: Colors.redAccent,
              thickness: 4, // zm 16,
              size: 0.8,
              angleRadians: dateTime.minute *
                  radiansPerTick, 
            ),
          ],
        ),
      ),
    );
  }
}
