import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'drawn_hand.dart';
import 'style.dart';

/// Total distance traveled by a second or a minute hand, each second or minute, respectively.
final radiansPerTick = radians(6);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(30);

class ClockHands extends StatelessWidget {
  final DateTime dateTime;

  ClockHands({this.dateTime});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        width: double.infinity,
        //padding: const EdgeInsets.all(20.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            DrawnHand(
              color: HourHandColor,
              thickness: HourHandThickness,
              size: HourHandSize,
              angleRadians: dateTime.hour * radiansPerHour +
                  (dateTime.minute / 60) * radiansPerHour,
            ),
            DrawnHand(
              color: MinuteHandColor,
              thickness: MinuteHandThickness,
              size: MinuteHandSize,
              angleRadians: dateTime.minute * radiansPerTick,
            ),
          ],
        ),
      ),
    );
  }
}
