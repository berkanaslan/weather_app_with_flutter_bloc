import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_with_flutter_bloc/models/weather.dart';

class WeatherApiClient {
  static const baseUrl = "https://www.metaweather.com/";
  final http.Client httpClient = http.Client();

  Future<int> getLocationId(String locationName) async {
    final locationUrl = baseUrl + "/api/location/search/?query=" + locationName;
    final incomingValues = await httpClient.get(locationUrl);

    if (incomingValues.statusCode != 200) {
      throw Exception("Veri getirilemedi.");
    } else {
      final incomingValuesJSON = (jsonDecode(incomingValues.body)) as List;
      return incomingValuesJSON[0]["woeid"];
    }
  }

  Future<Weather> getWeather(int locationId) async {
    final weatherUrl = baseUrl + "/api/location/" + locationId.toString();
    final incomingWeatherValues = await httpClient.get(weatherUrl);
    if (incomingWeatherValues.statusCode != 200) {
      throw Exception("Veri getirilemedi.");
    } else {
      final incomingValuesJSON = jsonDecode(incomingWeatherValues.body);
      return Weather.fromJson(incomingValuesJSON);
    }
  }
}
