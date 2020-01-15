// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

//import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';

import './clock.dart';
import './clock_text.dart';

//import 'container_hand.dart';
//import 'drawn_hand.dart';

/// Total distance traveled by a second or a minute hand, each second or minute, respectively.
//final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
//final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
class AnalogClock extends StatefulWidget {
  //const AnalogClock(this.model);
  const AnalogClock();

  //final ClockModel model; //zm

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  // var _now = DateTime.now();
  // Timer _timer;

  @override
  void initState() {
    super.initState();
    //widget.model.addListener(_updateModel);
    // Set the initial values.
    // _updateTime();
    // _updateModel();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    /*
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
    */
  }

  @override
  void dispose() {
    // _timer?.cancel();
    //  widget.model.removeListener(_updateModel);
    super.dispose();
  }

/*
  void _updateModel() {
    setState(() {
      // _temperature = widget.model.temperatureString;
      // _temperatureRange = '(${widget.model.low} - ${widget.model.highString})';
      // _condition = widget.model.weatherString;
      // _location = widget.model.location;
    });
  }

  void _updateTime() {
    setState(() {
     // _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      /*
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
     */ 
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    // There are many ways to apply themes to your clock. Some are:
    //  - Inherit the parent Theme (see ClockCustomizer in the
    //    flutter_clock_helper package).
    //  - Override the Theme.of(context).colorScheme.
    //  - Create your own [ThemeData], demonstrated in [AnalogClock].
    //  - Create a map of [Color]s to custom keys, demonstrated in
    //    [DigitalClock].
    /*
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
*/
    final time = DateFormat.Hms().format(DateTime.now());
    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/wood.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    width: constraints.maxHeight,
                    //  color: Colors.yellowAccent,
                    child: Stack(
                      children: <Widget>[
                        Clock(
                          //circleColor: Colors.transparent,
                          clockText: ClockText.arabic,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
