import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/constants/images.dart';
import 'package:weather_app/widgets/weather_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(WEATHER_API_KEY);
  Weather? _weather;
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getWeatherData("Vannappuram");
  }

  void _getWeatherData(String city) {
    _wf.currentWeatherByCityName(city).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _locationHeader(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Enter City',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _getWeatherData(_cityController.text);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            _dateTimeInfo(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            _weatherIcon(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _currentTemp(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            _extraInfo(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

          ],
        ),
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "  ${DateFormat("d.m.y").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 90,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 50,right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeatherItems(weather: 'wind speed', value: '${_weather?.windSpeed}', imageUrl: MyImages.wind, unit: 'km/h', conversionFactor: 3.6,),
          WeatherItems(weather: 'Humidity', value: '${_weather?.humidity}', imageUrl: MyImages.humidity, unit: '', conversionFactor: 1,),
          WeatherItems(weather: 'Cloudiness', value: '${_weather?.cloudiness}', imageUrl: MyImages.wind, unit: '', conversionFactor: 1,),


        ],
      ),
    );
  }
}
