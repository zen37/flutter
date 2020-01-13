// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import './clock.dart';
import './clock_text.dart';

//import 'container_hand.dart';
import 'drawn_hand.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
///
/// You can do better than this!
class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = DateTime.now();
  var _temperature = '';
  var _temperatureRange = '';
  var _condition = '';
  var _location = '';
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _temperatureRange = '(${widget.model.low} - ${widget.model.highString})';
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // There are many ways to apply themes to your clock. Some are:
    //  - Inherit the parent Theme (see ClockCustomizer in the
    //    flutter_clock_helper package).
    //  - Override the Theme.of(context).colorScheme.
    //  - Create your own [ThemeData], demonstrated in [AnalogClock].
    //  - Create a map of [Color]s to custom keys, demonstrated in
    //    [DigitalClock].
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            // Hour hand.
            primaryColor: Colors.grey[700], // zm Color(0xFF4285F4),
            // Minute hand.
            highlightColor: Colors.grey[700], //zm Color(0xFF8AB4F8),
            // Second hand.
            accentColor: Colors.red, // zm  Color(0xFF669DF6),
            backgroundColor: Colors
                .grey, //  Image.asset('wood.png').color, //zm Color(0xFFD2E3FC),
          )
        : Theme.of(context).copyWith(
            primaryColor: Color(0xFFD2E3FC),
            highlightColor: Color(0xFF4285F4),
            accentColor: Color(0xFF8AB4F8),
            backgroundColor: Color(0xFF3C4043),
          );

    final time = DateFormat.Hms().format(DateTime.now());
    /* zm
    final weatherInfo = DefaultTextStyle(
      style: TextStyle(color: customTheme.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_temperature),
          Text(_temperatureRange),
          Text(_condition),
          Text(_location),
        ],
      ),
    );
    */

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        //zm color: customTheme.backgroundColor,
        //  color: Colors.red,
        //  padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // zm
            Image.asset(
              "wood.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            // Example of a hand drawn with [CustomPainter].
            /*zm  
            DrawnHand(
              color: customTheme.accentColor,
              thickness: 4,
              size: 1,
              angleRadians: _now.second * radiansPerTick,
            ),
          */
            DrawnHand(
              color: customTheme.highlightColor,
              thickness: 4, // zm 16,
              size: 0.9,
              angleRadians: _now.minute * radiansPerTick,
            ),
            // Example of a hand drawn with [Container].
            DrawnHand(
              color: customTheme.primaryColor,
              thickness: 5, // zm 16,
              size: 0.5,
              angleRadians: _now.hour * radiansPerHour +
                  (_now.minute / 60) * radiansPerHour,
            ),
        
            Align(
              alignment: AlignmentDirectional.center,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    width: constraints.maxHeight,
                    //color: Colors.green,
                    child: Stack(
                      children: <Widget>[

                                 Clock(
                circleColor: Colors.blue,
                clockText: ClockText.arabic,
            ),

                        Container(
                width: double.infinity,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
              
                ),
                        ),
Padding(
      padding: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          width: double.infinity,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
        ),
      ),
        ),

                        Positioned(
                          bottom: constraints.maxHeight * 0.9,
                          left: constraints.maxHeight / 2 * 0.9,
                          child: Text(
                            '12',
                          ),
                        ),
                        PositionedDirectional(
                          start: (constraints.maxHeight / 2) * 1.5,
                          bottom: 0, // 20,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            // child: weatherInfo,
                          ),
                        ),

                        PositionedDirectional(
                          //top: constraints.maxHeight * 0.07,
                          //end: constraints.maxHeight * 0.25,
                          bottom: constraints.maxHeight * 0.867,
                          start: constraints.maxHeight * 0.667,
                          //constraints.maxHeight * 0.75 ,//  / 2,
                          child: Text(
                            '1',
                            //style: TextStyle(
                            //   fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                        Positioned(
                          bottom: constraints.maxHeight * 0.667,
                          left: constraints.maxHeight * 0.867,
                          child: Text(
                            '2',
                          ),
                        ),
                        PositionedDirectional(
                          bottom: (1 - cos(30)) * constraints.maxHeight / 2,
                          start: constraints.maxHeight / 8,
                          child: Text('7'),
                        ),
                        //  print('asdsadsddsa'),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text('3'),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Text('6'),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text('9'),
                        ),
                      
                      ],
                    ),
                  );
                },
              ),
            ),
            /* zm
            PositionedDirectional(
              start: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8),
                // child: weatherInfo,
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
