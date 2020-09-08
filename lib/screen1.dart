import 'dart:math';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:weather_app123/screen2.dart';
import 'package:weather_app123/screen3.dart';
import 'package:weather_app123/coronaVirus.dart';
import 'coronaCases.dart';
class screen1 extends StatelessWidget {
  var weather;
  var latitude;
  var longitude;
  var address;
  var worldCorona;
  var indiaCorona;
  screen1(this.weather,this.latitude,this.longitude,this.address,this.worldCorona);
  @override
  Widget build(BuildContext context) {
    var index=0;
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
          brightness: Brightness.dark
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          extendBodyBehindAppBar: true,
        appBar: GradientAppBar(
          gradient: LinearGradient(colors: [Color.fromRGBO(59, 176, 222,2),Color.fromRGBO(59, 176, 222,2)]),
          title: Marquee(
            child: Text(address.first.addressLine),
            animationDuration: Duration(seconds: 20),
            directionMarguee: DirectionMarguee.oneDirection,
          ),
          elevation: 0.0,actions: <Widget>[
          Container(
            child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screen2(weather)),
                  );
                },
                child: Icon(Icons.web_asset)
            ),
            padding: EdgeInsets.all(10),
          ),
          Container(
            child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screen3(latitude,longitude,weather)),
                  );
                },
                child: Icon(Icons.map)
            )
            ,padding: EdgeInsets.all(10),
          ),
        ],
        ),
      drawer: Drawer(
      ),
      body:Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset('assets/pic1.jpg',fit: BoxFit.cover,),
          getBody(weather,latitude,longitude)
        ],
      )
      ),
    );
  }
}
class getBody extends StatefulWidget {
  var weather;
  var latitude;
  var longitude;
  getBody(this.weather,this.latitude,this.longitude);
  @override
  _getBodyState createState() => _getBodyState(weather,latitude,longitude);
}

class _getBodyState extends State<getBody> {
  var weather;
  var latitude;
  var longitude;
  var weekday;
  var day;
  var month;
  var date;
  var timemilli;
  var hours;
  _getBodyState(this.weather,this.latitude,this.longitude);
  @override
  Widget build(BuildContext context) {
    print(weather['timezone']);
    date = DateTime.now();
    print(date);
    print(DateFormat('HH').format(date));
    print(DateFormat('EEEE').format(date).substring(0, 3));
    print(DateFormat('MMM').format(date));
    print(DateFormat('d').format(date));
    print(DateFormat('yyyy').format(date));

    var height= MediaQuery.of(context).size.height;
    return CustomScrollView(
        slivers: <Widget>[
             SliverToBoxAdapter(
               child: Container(
                 height:height*0.4,
               ),
             ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('${((weather["current"]["temp"]).roundToDouble()).toInt()}°',style: TextStyle(fontSize: 50,fontWeight:FontWeight.w300),),
                      Text('${weather['current']['weather'][0]['description']}')
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height:100,
              child: ListView.builder(
                itemCount: weather['daily'].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                   timemilli=weather['daily'][index]['dt'];
                   date = DateTime.fromMillisecondsSinceEpoch(timemilli*1000);
                   weekday=DateFormat('EEEE').format(date).substring(0, 3);
                   if(index==0){
                     weekday='ToDay';
                   }
                   month=DateFormat('MMM').format(date);
                   day=DateFormat('d').format(date);
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 60,
                    child: Column(
                      children: <Widget>[
                       Container(child: Text(weekday),margin: EdgeInsets.only(bottom: 2),),
                       Text(month+' '+day),
                       Image.network('http://openweathermap.org/img/wn/'+ weather['daily'][index]['weather'][0]['icon']+'@2x.png',width: 40,height: 40,),
                          Marquee(child: Text( weather['daily'][index]['weather'][0]['description'])),

                      ],
                    )
                  );
                  }
              ),
            ),
          ),
          SliverToBoxAdapter(
               child: Container(
                 margin: EdgeInsets.symmetric(vertical: 30),
                 height:100,
                 child: ListView.builder(
                   itemCount: weather["hourly"].length,
                   scrollDirection: Axis.horizontal,
                     itemBuilder: (context,index){
                       timemilli=weather["hourly"][index]['dt'];
                       date = DateTime.fromMillisecondsSinceEpoch(timemilli*1000);
                     hours=DateFormat('HH').format(date);
                     hours=int.parse(hours);
                     if(hours>=12){
                         if(hours%12==0 && hours==12){
                           hours=12.toString()+'pm';
                         }else if(hours%12==0 && hours==24){
                           hours=12.toString()+'am';
                         }else{
                           hours=(hours%12).toString()+'pm';
                         }
                     }
                     else{
                       if(hours==0){
                         hours=12.toString()+'am';
                       }else{
                         hours=(hours%12).toString()+'am';
                       }
                     }
                     return Container(
                       margin: EdgeInsets.symmetric(horizontal: 10),
                       width: 60,
                       child: Column(
                         children: <Widget>[
                           Text(hours),
                           Image.network('http://openweathermap.org/img/wn/'+ weather["hourly"][index]['weather'][0]['icon']+'@2x.png',width: 40,height: 40,),
                           Text('${((weather["hourly"][index]["temp"]).roundToDouble()).toInt()}'+'°'),
                         ],
                       ),
                     );
                     }
                 ),
               ),
          ),
          SliverGrid.count(
              crossAxisCount: 2,
            mainAxisSpacing: 30.0,
            crossAxisSpacing: 70.0,
            childAspectRatio: 3,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Pressure'),
                    Text(weather["current"]["pressure"].toString()+' hPa',style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Container(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Humidity'),
                    Text(weather["current"]["humidity"].toString()+' %',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Dew_Point'),
                    Text('${((weather["current"]["dew_point"]).roundToDouble()).toInt()}'+'°',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Visibility'),
                    Text('${(weather["current"]["visibility"])*0.001}'+' km',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('WindSpeed'),
                    Text('${weather["current"]["wind_speed"]}'+" m/s",style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Wind_deg'),
                    Text(weather["current"]["wind_deg"].toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Cloudiness'),
                    Text(weather["current"]["clouds"].toString()+" %",style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('UVI'),
                    Text(weather["current"]["uvi"].toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ],
          )

        ],
    );
  }


}

