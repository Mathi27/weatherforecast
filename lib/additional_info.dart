import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // containter for humidity
          Container(
            padding: EdgeInsets.all(10),
            child: const Column(
              children: [
                Icon(
                  Icons.water_drop,
                  size: 35,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Humidity"),
                Text(
                  "94",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // containter for wind speed
          Container(
            padding: EdgeInsets.all(10),
            child: const Column(
              children: [
                Icon(
                  Icons.air,
                  size: 35,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Wind Speed"),
                Text(
                  "77.67",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // containter for humidity
          Container(
            padding: EdgeInsets.all(10),
            child: const Column(
              children: [
                Icon(
                  Icons.beach_access,
                  size: 35,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Pressure"),
                Text(
                  "1006",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
