import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_flutter_bloc/blocs/weather/theme/theme_bloc.dart';
import 'package:weather_app_with_flutter_bloc/blocs/weather/weather_bloc.dart';
import 'package:weather_app_with_flutter_bloc/locator.dart';
import 'package:weather_app_with_flutter_bloc/widgets/weather_app.dart';

void main() {
  setupLocator();
  runApp(BlocProvider<ThemeBloc>(
    create: (context) => ThemeBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: BlocProvider.of<ThemeBloc>(context),
      builder: (context, ThemeState state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather Application',
            theme: (state as ApplicationThemeState).themeData,
            home: BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc(),
              child: WeatherApp(),
            ),
        );
      },
    );
  }
}
