import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/weather_item.dart';
import 'package:weather_app/constants.dart';

class DetailPage extends StatefulWidget {
  final dailyForecastWeather;

  const DetailPage({super.key, this.dailyForecastWeather});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    // function get weather
    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].toInt();

      var parseDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat("EEEE, d MMMM yyyy").format(parseDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int minTemperature = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemperature = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature
      };

      return forecastData;
    }

    return Scaffold(
      backgroundColor: _constants.primaryColor,
      appBar: AppBar(
        title: const Text("Forecast"),
        centerTitle: true,
        backgroundColor: _constants.primaryColor,
        elevation: 0.0,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 8.0),
        //     child:
        //         IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        //   )
        // ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 70,
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .75,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 300,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.center,
                            colors: [
                              Color(0xffa9c1f5),
                              Color(0xff6696f5),
                            ]),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(.1),
                            offset: const Offset(0, 25),
                            blurRadius: 3,
                            spreadRadius: -10,
                          )
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Image.asset("assets/" +
                                getForecastWeather(0)["weatherIcon"]),
                            top: 10,
                            left: 10,
                            width: 150,
                          ),
                          Positioned(
                              top: 165,
                              left: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  getForecastWeather(0)["weatherName"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              )),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["maxWindSpeed"],
                                    unit: "km/h",
                                    imageUrl: "assets/windspeed.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)["avgHumidity"],
                                    unit: "%",
                                    imageUrl: "assets/humidity.png",
                                  ),
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["chanceOfRain"],
                                    unit: "%",
                                    imageUrl: "assets/lightrain.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getForecastWeather(0)["maxTemperature"]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = _constants.shader,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = _constants.shader,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 335,
                              left: 0,
                              child: SizedBox(
                                height: 400,
                                width: size.width * .9,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: min(weatherData.length, 3),
                                  itemBuilder: (BuildContext context, int index) {
                                    var forecast = getForecastWeather(index);

                                    return Card(
                                      elevation: 3.0,
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(forecast["forecastDate"], style: const TextStyle(
                                                  color: Color(0xff6696f5),
                                                  fontWeight: FontWeight.w600,
                                                ),),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(forecast["minTemperature"].toString(), style: TextStyle(
                                                          color: _constants.greyColor,
                                                          fontSize: 30,
                                                          fontWeight: FontWeight.w600,
                                                        ),),
                                                        Text('°', style: TextStyle(
                                                          color: _constants.greyColor,
                                                          fontSize: 30,
                                                          fontWeight: FontWeight.w600,
                                                          fontFeatures: const [
                                                            FontFeature.enable("sups"),
                                                          ],
                                                        ),),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(forecast["maxTemperature"].toString(), style: TextStyle(
                                                          color: _constants.blackColor,
                                                          fontSize: 30,
                                                          fontWeight: FontWeight.w600,
                                                        ),),
                                                        Text('°', style: TextStyle(
                                                          color: _constants.blackColor,
                                                          fontSize: 30,
                                                          fontWeight: FontWeight.w600,
                                                          fontFeatures: const [
                                                            FontFeature.enable("sups"),
                                                          ],
                                                        ),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset("assets/" + forecast["weatherIcon"], width: 30,),
                                                    const SizedBox(width: 5,),
                                                    Text(forecast["weatherName"], style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                    ),)
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(forecast["chanceOfRain"].toString() + "%", style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                    ),),
                                                    const SizedBox(width: 5,),
                                                    Image.asset("assets/lightrain.png", width: 30,),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
