import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_flutter_bloc/blocs/weather/theme/theme_bloc.dart';
import 'package:weather_app_with_flutter_bloc/blocs/weather/weather_bloc.dart';
import 'package:weather_app_with_flutter_bloc/widgets/gradient-background.dart';
import 'package:weather_app_with_flutter_bloc/widgets/last_update.dart';
import 'package:weather_app_with_flutter_bloc/widgets/location.dart';
import 'package:weather_app_with_flutter_bloc/widgets/max_and_min_temperature.dart';
import 'package:weather_app_with_flutter_bloc/widgets/select_location.dart';
import 'package:weather_app_with_flutter_bloc/widgets/weather_status_image_and_temp.dart';

class WeatherApp extends StatelessWidget {
  String locationFromUser = "";
  Completer<void> _completer = Completer<void>();

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              locationFromUser = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SelectLocation()));
              debugPrint("$locationFromUser");
              if (locationFromUser != null) {
                await _weatherBloc.add(FetchWeatherEvent(cityName: locationFromUser));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocBuilder(
          cubit: _weatherBloc,
          builder: (context, WeatherState state) {
            if (state is WeatherInitial) {
              return Center(
                child: Text("Bir konum seçilmedi."),
              );
            } else if (state is WeatherLoadingState) {
              return CircularProgressIndicator();
            } else if (state is WeatherLoadedState) {
              final incomingWeather = state.weather;
              final weatherStateAbbr =
              state.weather.consolidatedWeather[0].weatherStateAbbr.toString();
              _completer.complete();
              _completer = Completer();

              locationFromUser = state.weather.title;

              BlocProvider.of<ThemeBloc>(context)
                  .add(ChangeThemeEvent(weatherStateAbbr: weatherStateAbbr));

              return BlocBuilder(
                cubit: BlocProvider.of<ThemeBloc>(context),
                builder: (context, ThemeState state) {
                  return GradientBackground(
                    color: (state as ApplicationThemeState).bgColor,
                    child: RefreshIndicator(
                      onRefresh: () {
                        _weatherBloc.add(RefreshWeatherEvent(cityName: locationFromUser));
                        return _completer.future;
                      },
                      child: ListView(
                        children: [
                          LocationWidget(
                            selectedLoctaion: incomingWeather.title, //locationFromUser,
                          ),
                          WeatherStatusImageAndTemp(),
                          MaxAndMinTemperature(),
                          LastUpdateWidget(),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("Konum bilgisi bulunamadı."),
              );
            }
          },
        ),
      ),
    );
  }
}
