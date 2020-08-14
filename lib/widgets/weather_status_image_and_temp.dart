import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_flutter_bloc/blocs/weather/theme/theme_bloc.dart';
import 'package:weather_app_with_flutter_bloc/blocs/weather/weather_bloc.dart';

class WeatherStatusImageAndTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder(
          cubit: _weatherBloc,
          builder: (context, WeatherState state) {
            final imgName = (state as WeatherLoadedState)
                .weather
                .consolidatedWeather[0]
                .weatherStateAbbr;
            final temp = (state as WeatherLoadedState)
                .weather
                .consolidatedWeather[0]
                .theTemp
                .floor()
                .toString();
            return Column(
              children: [
                Image.network(
                  "https://www.metaweather.com/static/img/weather/png/" +
                      imgName +
                      ".png",
                  width: 128,
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder(
                  cubit: BlocProvider.of<ThemeBloc>(context),
                  builder: (context, state) => Text(
                    temp + "°C",
                    style: TextStyle(
                        color: (state as ApplicationThemeState).textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
