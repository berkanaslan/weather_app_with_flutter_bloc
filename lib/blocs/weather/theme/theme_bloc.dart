import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ApplicationThemeState(themeData: ThemeData.light(), bgColor: Colors.blue));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    ApplicationThemeState applicationThemeState;
    if (event is ChangeThemeEvent) {
      switch (event.weatherStateAbbr) {
        case "sn": //Snow
        case "sl": //Sleet
        case "h": //Hail
        case "t": //Thunderstrom
        case "hc": //Heavy cloud
          applicationThemeState = ApplicationThemeState(
              themeData: ThemeData(primaryColor: Colors.blueGrey),
              bgColor: Colors.blueGrey,
              textColor: Colors.white);
          break;
        case "hr": //Heavy rain
        case "lr": //Light rain
        case "s": //Showers
          applicationThemeState = ApplicationThemeState(
              themeData: ThemeData(primaryColor: Colors.indigo),
              bgColor: Colors.indigo,
              textColor: Colors.white);
          break;
        case "lc": // Light Cloud
        case "c": // Clear
          applicationThemeState = ApplicationThemeState(
              themeData: ThemeData(primaryColor: Colors.orangeAccent),
              bgColor: Colors.yellow,
              textColor: Colors.black);
          break;
      }
      yield applicationThemeState;
    }
  }
}
