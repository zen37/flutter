import 'dart:async';
import 'package:flutter/material.dart';
import './clock_text.dart';
import './clock_face.dart';

typedef TimeProducer = DateTime Function();

class Clock extends StatefulWidget {

  final Color circleColor;
  final ClockText clockText;
  final TimeProducer getCurrentTime;
  final Duration updateDuration;

  Clock({
         this.circleColor = Colors.grey,
         this.clockText = ClockText.arabic,
         this.getCurrentTime = getSystemTime,
         this.updateDuration = const Duration(seconds: 1)
         });

  static DateTime getSystemTime() {
    return new DateTime.now();
  }

  @override
  State<StatefulWidget> createState() {
    return _Clock();
  }
}

class _Clock extends State<Clock> {
  Timer _timer;
  DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = new DateTime.now();
    this._timer = new Timer.periodic(widget.updateDuration, setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = new DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: buildClockCircle(context),
    );
  }

  Container buildClockCircle(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
         shape: BoxShape.circle,
         // scolor: widget.circleColor,
      ),

      child: ClockFace(
          clockText : widget.clockText,
          dateTime: dateTime,
      ),
    );
  }
}