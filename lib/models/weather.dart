import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Weather {
  final double temp;
  final double feelsLike;
  final double low;
  final double high;
  final String description;

  Weather({
    this.temp,
    this.description,
    this.feelsLike,
    this.high,
    this.low});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json["main"]["temp"].todouble(),
      feelsLike: json['main']['feels_like'],
      high: json['main']['temp_max'],
      low: json['main']['temp_min'],
      description: json['weather'][0]['description'],
    );
  }
}

