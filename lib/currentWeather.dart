import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/weather.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key key}) : super(key: key);

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
            builder: (context, snapshot){
              if(snapshot != null){
                Weather _weather = snapshot.data;
                if(_weather == null){
                  return Text("Error getting data");
                }
                else {
                  return weatherBox(_weather);
                }
              }
              else{
                return CircularProgressIndicator();
              }
            },
              future : getCurrentWeather(),
          ),
      ),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Column(
      children: <Widget>[
        Text("${_weather.temp}C"),
        Text("${_weather.feelsLike}C"),
        Text("${_weather.high}C"),
        Text("${_weather.low}C"),
        Text("${_weather.description}C"),
      ]
    );
  }

  Future getCurrentWeather() async {
    Weather weather;
    String city = "India";
    String apikey = "475a156a703afb9b9f86c9ee2a40282e";
    var url = Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey');
    final String baseUrl= "http://api.openweathermap.org/data/2.5/weather?q=Lucknow&appid=475a156a703afb9b9f86c9ee2a40282e";

    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body.toString()));
    }
    else{
      //do something
    }
    return weather;
  }
}
