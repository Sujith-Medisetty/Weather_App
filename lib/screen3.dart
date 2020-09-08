import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:collection';
class screen3 extends StatefulWidget {
  var latitude;
  var longitude;
  var weather;
  screen3(this.latitude,this.longitude,this.weather);
  @override
  _screen3State createState() => _screen3State(latitude,longitude,weather);
}

class _screen3State extends State<screen3> {
  var latitude;
  var longitude;
  var weather;
  _screen3State(this.latitude,this.longitude,this.weather);
  @override
  Widget build(BuildContext context) {
    return googlemap(latitude,longitude,weather);
  }
}
class googlemap extends StatefulWidget {
  var latitude;
  var longitude;
  var weather;
  googlemap(this.latitude,this.longitude,this.weather);
  @override
  _googlemapState createState() => _googlemapState(latitude,longitude,weather);
}

class _googlemapState extends State<googlemap> {
  var latitude;
  var longitude;
  var weather;
  _googlemapState(this.latitude,this.longitude,this.weather);
  Set<Marker> markers=HashSet<Marker>();
  GoogleMapController Mcontroller;
  void onmapcreated(GoogleMapController controller){
    Mcontroller=controller;
    setState(() {
      markers.add(
          Marker(markerId: MarkerId('0'),
              position:LatLng(latitude,longitude),
              infoWindow: InfoWindow(
                  title:'${roundDouble(weather["current"]["temp"],0).toInt()}°',
                  snippet:'${weather['current']['weather'][0]['description']}'
              ))
      );
    });
  }
  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: onmapcreated,
          initialCameraPosition: CameraPosition(
              target: LatLng(latitude,longitude),
              zoom: 10
          ),
          markers: markers,
        ),
      ),
    );
  }
}