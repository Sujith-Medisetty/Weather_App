import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class splashEvent extends Equatable{
  @override
  List<Object> get props =>[];
}
class startEvent extends splashEvent{

}
class splashState extends Equatable{
  @override
  List<Object> get props =>[];
}
class screen1State extends splashState{
  var latitude;
  var longitude;
  screen1State(this.latitude,this.longitude);
}
class screen2State extends splashState{
  var weather;
  var address;
  var worldCorona;

  screen2State(this.weather,this.address,this.worldCorona);
}
class welcome extends splashState{

}
class doneState extends splashState{

}
class splashBloc extends Bloc<splashEvent,splashState>{
  var latitude;
  var longitude;
  Future<dynamic> getlocation() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude=position.latitude;
    longitude=position.longitude;
    return position;
  }

  @override
  splashState get initialState => welcome();

  @override
  Stream<splashState> mapEventToState(splashEvent event) async*{
    if(event is startEvent){
      var position=await getlocation();
      yield screen1State(latitude,longitude);
      final result=await http.Client().get('https://api.openweathermap.org/data/2.5/onecall?lat=${latitude}&lon=${longitude}&%20exclude=hourly,daily&appid=a47f1dc943dabdd586354fc08bf6dd9e&units=metric');
      if(result.statusCode!=200){
        print('error1');
        throw Exception();
      }
      final data=await http.Client().get('https://api.covid19api.com/summary');
      final worldCororna=json.decode(data.body);
     /* final data2=await http.Client().get('https://api.covidindiatracker.com/state_data.json');
      final indiaCorona=json.decode(data2.body);*/
      final coordinates = Coordinates(latitude,longitude);
      var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      final jsonDecoded=json.decode(result.body);
      final jsonWeather=jsonDecoded;
      yield screen2State(jsonWeather,address,worldCororna);
      await Future.delayed(const Duration(milliseconds: 50));
      yield doneState();
    }
  }


}