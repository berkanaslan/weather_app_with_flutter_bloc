import 'package:weather_app_with_flutter_bloc/data/weather_api_client.dart';
import 'package:weather_app_with_flutter_bloc/locator.dart';
import 'package:weather_app_with_flutter_bloc/models/weather.dart';

class WeatherRepository {
  WeatherApiClient weatherApiClient = locator<WeatherApiClient>();

  Future<Weather> getWeather(String location) async {
    final int cityID = await weatherApiClient.getLocationId(location);
    return await weatherApiClient.getWeather(cityID);
  }
}
