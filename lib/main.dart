// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(MaterialApp(
    title: 'WeWeather App',
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humadity;
  var windspeed;

  Future getWeather() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=Dhaka&appid=1d7b9f51f0dfbd52e4e950cfa24bdbde');

    var results = jsonDecode(response.body);

    setState(() {
      temp = results['main']['temp'];
      description = results['weather'][0]['description'];
      currently = results['weather'][0]['main'];
      humadity = results['main']['humadity'];
      windspeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Currently at Dhaka',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() : 'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    currently != null
                        ? currently.toString() + ' \u00b0'
                        : 'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(
                      (FontAwesomeIcons.thermometerHalf),
                    ),
                    title: Text('Temparature'),
                    trailing: Text(
                      temp != null ? temp.toString() : 'Loading...',
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(
                      (FontAwesomeIcons.cloud),
                    ),
                    title: Text('Weather: '),
                    trailing: Text(description != null
                        ? description.toString()
                        : 'Loading...'),
                  ),
                  ListTile(
                    leading: FaIcon(
                      (FontAwesomeIcons.sun),
                    ),
                    title: Text('Humidity'),
                    trailing: Text(
                        humadity != null ? humadity.toString() : 'Loading...'),
                  ),
                  ListTile(
                    leading: FaIcon(
                      (FontAwesomeIcons.wind),
                    ),
                    title: Text('Wind speed'),
                    trailing: Text(windspeed != null
                        ? windspeed.toString()
                        : 'Loading...'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
