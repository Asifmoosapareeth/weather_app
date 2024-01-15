import 'package:flutter/material.dart';

class WeatherItems extends StatelessWidget {
  const WeatherItems({
    Key? key,
    required this.weather,
    required this.value,
    required this.imageUrl,
    required this.unit,
    required this.conversionFactor,
  }) : super(key: key);

  final String weather;
  final String value;
  final String imageUrl;
  final String unit;
  final double conversionFactor;

  @override
  Widget build(BuildContext context) {
    // Attempt to parse the attribute value
    double attributeValue = double.tryParse(value) ?? 0.0;

    // Convert the attribute value using the provided conversion factor
    double convertedValue = attributeValue * conversionFactor;

    return Column(
      children: [
        Text(weather, style: TextStyle(fontSize: 20, color: Colors.black54)),
        SizedBox(height: 15),
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Color(0xff9db8ff),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image(
            image: AssetImage(imageUrl),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 15),
        // Display the attribute value with its unit
        Text('${convertedValue.toStringAsFixed(1)} $unit',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
