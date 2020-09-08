import 'package:flutter/material.dart';
import 'package:weather_app123/screen1.dart';

import 'coronaVirus.dart';
import 'one.dart';
class intermediate extends StatefulWidget {
  var weather;
  var latitude;
  var longitude;
  var address;
  var worldCorona;

  intermediate(this.weather,this.latitude,this.longitude,this.address,this.worldCorona);
  @override
  _intermediateState createState() => _intermediateState(weather,latitude,longitude,address,worldCorona);
}

class _intermediateState extends State<intermediate> with SingleTickerProviderStateMixin {
  TabController controller;
  var weather;
  var latitude;
  var longitude;
  var address;
  var worldCorona;

  _intermediateState(this.weather,this.latitude,this.longitude,this.address,this.worldCorona);

  @override
  void initState() {
    controller = TabController(length:3,vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home:Scaffold(
          body:TabBarView(
            controller: controller,
            children: <Widget>[
              screen1(weather,latitude,longitude,address,worldCorona),
              coronaVirus(worldCorona),
              one()
            ],
          ),
          bottomNavigationBar: Material(
            color: Colors.teal,
            child: TabBar(
              controller: controller,
              tabs: <Widget>[
                Tab(child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.wb_sunny),
                    Text('Weather')
                  ],
                )),
                Tab(child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/corona.png',width: 30,height:30,color: Colors.white,),
                    Text('World Wide')
                  ],
                )),
                Tab(child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/corona.png',width: 30,height:30,color: Colors.white,),
                    Text('India Wide')
                  ],
                )),
              ],
            ),
          ),
        )
    );
  }
}
