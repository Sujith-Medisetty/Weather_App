import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:marquee_widget/marquee_widget.dart';


class screen2 extends StatelessWidget {
  var weather;
  screen2(this.weather);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.black,
            accentColor: Colors.black,
            brightness: Brightness.dark
        ),
        home:one(weather)
    );
  }
}
class one extends StatefulWidget {
  var weather;
  one(this.weather);
  @override
  _oneState createState() => _oneState(weather);
}

class _oneState extends State<one> {
  var weather;
  var timemilli;
  var date;
  var weekday;
  var month;
  var day;
  var year;
  _oneState(this.weather);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF89ABE3FF),
        extendBodyBehindAppBar: true,
      appBar: AppBar(title:Center(child: Text('7 Days Forecast')),elevation: 0.0,backgroundColor:Colors.transparent),
        body:CarouselSlider.builder(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            initialPage: 0,
            enlargeCenterPage: true,
            autoPlay: false,
            reverse: false,
            enableInfiniteScroll: false,
            scrollDirection: Axis.horizontal,
          ),
          itemCount: weather['daily'].length,
          itemBuilder: (BuildContext context, int itemIndex) {
            timemilli=weather['daily'][itemIndex]['dt'];
            date = DateTime.fromMillisecondsSinceEpoch(timemilli*1000);
            weekday=DateFormat('EEEE').format(date).substring(0, 3);
            if(itemIndex==0){
              weekday='ToDay';
            }
            month=DateFormat('MMM').format(date);
            day=DateFormat('d').format(date);
            year=DateFormat('yyyy').format(date);
             return  Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height*0.7,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height*0.2,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Container(
                                child: CustomScrollView(
                                  slivers: <Widget>[
                                    SliverToBoxAdapter(
                                      child: Container(
                                        padding: EdgeInsets.all(3.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text(month+" "+day+" , "+year+"  ("+weekday+")"),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SliverToBoxAdapter(
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text('${((weather["daily"][itemIndex]["temp"]['day']).roundToDouble()).toInt()}°',style: TextStyle(fontSize: 50,fontWeight:FontWeight.w300),),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: <Widget>[
                                             Image.network('http://openweathermap.org/img/wn/'+ weather['daily'][itemIndex]['weather'][0]['icon']+'@2x.png',width: 40,height: 40,),
                                             Text('${weather['daily'][itemIndex]['weather'][0]['description']}')
                                           ],
                                         )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                            Container(
                              height:MediaQuery.of(context).size.height*0.5 ,
                              padding: EdgeInsets.all(5),
                              child: CustomScrollView(
                                slivers: <Widget>[
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
                                            Text('Max Temp'),
                                            Text(weather["daily"][itemIndex]["temp"]["max"].toString()+'°',style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('Min Temp'),
                                            Text(weather["daily"][itemIndex]["temp"]["min"].toString()+'°',style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('Pressure'),
                                            Text(weather["daily"][itemIndex]["pressure"].toString()+' hPa',style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('Humidity'),
                                            Text(weather["daily"][itemIndex]["humidity"].toString()+' %',style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('Dew_Point'),
                                            Text('${((weather["daily"][itemIndex]["dew_point"]).roundToDouble()).toInt()}'+'°',style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('WindSpeed'),
                                            Text('${weather["daily"][itemIndex]["wind_speed"]}'+" m/s",style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('Wind_deg'),
                                            Text(weather["daily"][itemIndex]["wind_deg"].toString()+"°",style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('Cloudiness'),
                                            Text(weather["daily"][itemIndex]["clouds"].toString()+" %",style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('UVI'),
                                            Text(weather["daily"][itemIndex]["uvi"].toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('Prediction'),
                                            Text('${(((weather["daily"][itemIndex]["pop"])*100).toInt())}'+" %",style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('Precipitation'),
                                            Text(weather["daily"][itemIndex]["rain"].toString()+' mm',style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                      Container(

                                        child: Column(
                                          children: <Widget>[
                                            Expanded(child: Image.network('http://openweathermap.org/img/wn/'+ weather["daily"][itemIndex]['weather'][0]['icon']+'@2x.png',width: 40,height: 40,)),
                                            Expanded(child: Marquee(child: Text( weather['daily'][itemIndex]['weather'][0]['description'])),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                    ),
                  ],
                ),
              );}
        )
    );
  }
}
