part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent([List props = const []]);
}

class FetchWeatherEvent extends WeatherEvent {
  String cityName;

  FetchWeatherEvent({@required this.cityName});

  @override
  // TODO: implement props
  List<Object> get props => [cityName];
}

class RefreshWeatherEvent extends WeatherEvent {
  String cityName;

  RefreshWeatherEvent({@required this.cityName});

  @override
  // TODO: implement props
  List<Object> get props => [cityName];
}
