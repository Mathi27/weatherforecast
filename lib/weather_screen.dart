import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weatherapp/additional_info.dart';
import 'package:weatherapp/hourly_forecast.dart';

import 'package:http/http.dart' as http;
import 'package:weatherapp/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>?>? weatherData = Future.value(null);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherData = getCurrentWeather();
  }

  Future<Map<String, dynamic>?> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw 'An Unexpected Error occurred: ${data['message']}';
      }
      print(data['list'][0]['main']['temp']);

      debugPrint(result.body);
      print('API Response: $data');
      return data;
    } catch (e) {
      print('Error fetching weather data: $e');
      throw 'Error fetching weather data: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Weather App",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {
              weatherData = getCurrentWeather();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder(
        future: weatherData,
        builder: (context, snapshot) {
          // snapshot allows to handle states. async states.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return const Center(child: Text("oops ! something went wrong"));
          }

          if (snapshot.hasData) {
            final data = snapshot.data!;
            print(
                "---------------------${data['list'][0]['main']['temp']}--------------------");
            final currentWeatherData = data['list'][0];
            final currentTemp = data['list'][0]['main']['temp'];
            final currentSky = data['list'][0]['weather'][0]['main'];
            final currentPressure = currentWeatherData['main']['pressure'];
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // main Card;
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.2,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      elevation: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$currentTemp K',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                color: Colors.white,
                                size: 65,
                              ),
                              Text(
                                "$currentSky",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Weather Forecast',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          HourlyForecast(),
                          HourlyForecast(),
                          HourlyForecast(),
                          HourlyForecast(),
                          HourlyForecast(),
                          HourlyForecast(),
                          HourlyForecast(),
                          HourlyForecast(),
                          HourlyForecast(),
                          HourlyForecast(),
                          HourlyForecast(),
                        ],
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  // warther forecast cards.

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Additional Information',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AdditionalInfo(),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text("No data available"),
            );
          }
        },
      ),
    );
  }
}
