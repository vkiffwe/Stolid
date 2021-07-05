import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stolid/models/sample_data.dart';
import '../models/weather.dart';
import 'data_service.dart';

class CurrentWeatherPage extends StatefulWidget {
  //const CurrentWeatherPage({Key key}) : super(key: key);

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  final _cityTextController = TextEditingController();
  //creating an instance of data service
  final _dataService = DataService();
//binding data to UI
  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //adding if code
            if (_response != null)
              Column(
                children: [
                  Image.network(_response.iconUrl),
                  Text('${_response.tempInfo.temperature}',
                    style: TextStyle(fontSize: 40),),
                  Text(_response.weatherInfo.description)
                ],
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                width: 150,
                child: TextField(
                  controller: _cityTextController,
                  decoration: InputDecoration(labelText: 'City'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(onPressed: _search, child: Text('Search')),
          ],
        ),
          // child: FutureBuilder(
          //   builder: (context, snapshot){
          //     if(snapshot != null){
          //       Weather _weather = snapshot.data;
          //       if(_weather == null){
          //         return Text("Error getting data");
          //       }
          //       else {
          //         return weatherBox(_weather);
          //       }
          //     }
          //     else{
          //       return CircularProgressIndicator();
          //     }
          //   },
          //     future : getCurrentWeather(),
          // ),
      ),
    );
  }
  void _search() async{
    final response = await _dataService.getWeather(_cityTextController.text);
    // print(response.cityName);
    // print(response.tempInfo.temperature);
    // print(response.weatherInfo.description);
//UI
    setState(()=>_response = response);
  }

  // Widget weatherBox(Weather _weather) {
  //   return Column(
  //     children: <Widget>[
  //       Text("${_weather.temp}C"),
  //       Text("${_weather.feelsLike}C"),
  //       Text("${_weather.high}C"),
  //       Text("${_weather.low}C"),
  //       Text("${_weather.description}C"),
  //     ]
  //   );
  // }

  // Future getCurrentWeather() async {
  //   Weather weather;
  //   String city = "India";
  //   String apikey = "12ac698babd0172fd0086ade7d43580d";
  //   var url = Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey');
  //   final String baseUrl= "http://api.openweathermap.org/data/2.5/weather?q=Lucknow&appid=12ac698babd0172fd0086ade7d43580d";
  //
  //   final response = await http.get(Uri.parse(baseUrl));
  //   if (response.statusCode == 200) {
  //     weather = Weather.fromJson(jsonDecode(response.body.toString()));
  //   }
  //   else{
  //     //do something
  //   }
  //   return weather;
  // }
}
