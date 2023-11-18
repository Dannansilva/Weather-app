import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/models/weather_model.dart';

class WeatherService {
  static const Base_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);
  Future<weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$Base_URL ?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fail to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    //get permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //fetch current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // convert the location into a List of placemark object
    List<Placeholder> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    // extract the city name from the first placemark
    String? city = placemark[0].locality;
    return city ?? "" ;
  }
}