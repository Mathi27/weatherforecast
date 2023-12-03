import 'package:flutter/material.dart';

class HourlyForecast extends StatefulWidget {
  const HourlyForecast({super.key});

  @override
  State<HourlyForecast> createState() => _HourlyForecastState();
}

class _HourlyForecastState extends State<HourlyForecast> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    "12:30",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Icon(
                    Icons.cloud,
                    size: 32,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("301.54")
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
