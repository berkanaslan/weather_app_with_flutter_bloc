import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_flutter_bloc/blocs/weather/theme/theme_bloc.dart';
import 'package:weather_app_with_flutter_bloc/blocs/weather/weather_bloc.dart';

class MaxAndMinTemperature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder(
        cubit: _weatherBloc,
        builder: (context, WeatherState state) {
          final minTemp = (state as WeatherLoadedState)
              .weather
              .consolidatedWeather[0]
              .minTemp
              .floor()
              .toString();
          final maxTemp = (state as WeatherLoadedState)
              .weather
              .consolidatedWeather[0]
              .maxTemp
              .floor()
              .toString();
          return BlocBuilder(
            cubit: BlocProvider.of<ThemeBloc>(context),
            builder: (context, state) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Max: " + maxTemp + "°C",
                  style: TextStyle(
                    color: (state as ApplicationThemeState).textColor,
                  ),
                ),
                Text("Min: " + minTemp + "°C",
                    style: TextStyle(
                      color: (state as ApplicationThemeState).textColor,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
