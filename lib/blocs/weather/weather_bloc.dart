import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app_with_flutter_bloc/data/weather_repository.dart';
import 'package:weather_app_with_flutter_bloc/locator.dart';
import 'package:weather_app_with_flutter_bloc/models/weather.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository = locator<WeatherRepository>();

  WeatherBloc() : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherLoadingState();
      try {
        // Get city's weather details:
        final calledWeather = await weatherRepository.getWeather(event.cityName);
        if (event.cityName != null){
          final calledWeather = await weatherRepository.getWeather(event.cityName);
          yield WeatherLoadedState(weather: calledWeather);
        } else {
          yield WeatherErrorState();
        }
      } catch (e) {
        yield WeatherErrorState();
      }
    } else if (event is RefreshWeatherEvent) {
      try {
        // Get city's weather details:
        final calledWeather = await weatherRepository.getWeather(event.cityName);
        yield WeatherLoadedState(weather: calledWeather);
      } catch (e) {
        yield state;
      }
    }
  }
}
