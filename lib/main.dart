import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app123/screen1.dart';
import 'package:weather_app123/splashBloc.dart';

import 'intermediate.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var weather;
  var latitude;
  var longitude;
  var address;
  var worldCorona;
  var indiaCorona;
  splashBloc bloc1=splashBloc();
  void initState(){
    bloc1.add(startEvent());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: BlocBuilder(
            bloc: bloc1,
            builder: (context,state){
              if(state is doneState){
                return screen1(weather,latitude,longitude,address,worldCorona);
              }
              else if(state is screen1State){
                latitude=state.latitude;
                longitude=state.longitude;
                print(latitude);
                print(longitude);
                return splash1();
              } else if(state is screen2State){
                address=state.address;
                weather=state.weather;
                worldCorona=state.worldCorona;

                return splash2();
              }else{
                return splash3();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget splash1(){
    return Container(
      color: Colors.redAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(backgroundColor: Colors.yellow,child: Text('W'),),
            Text('Getting GeoLocation...')
          ],
        ),
      ),
    );
  }
  Widget splash2(){
    return Container(
      color: Colors.redAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(backgroundColor: Colors.yellow,child: Text('W'),),
            Text('getting weather data...')
          ],
        ),
      ),
    );
  }
  Widget splash3(){
    return  Container(
      color: Colors.redAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(backgroundColor: Colors.yellow,child: Text('W'),),
            Text('Welcome...')
          ],
        ),
      ),
    );
  }
}


