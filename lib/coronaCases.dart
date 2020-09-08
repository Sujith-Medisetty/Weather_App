import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
class coronaCases extends StatelessWidget {
  var coronaDetails;
  int index;
  coronaCases(this.coronaDetails,this.index);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark
      ),
      debugShowCheckedModeBanner: false,
      home: coronaCases2(coronaDetails,index),
    );
  }
}
class coronaCases2 extends StatefulWidget {
  var coronaDetails;
  int index;
  coronaCases2(this.coronaDetails,this.index);
  @override
  _coronaCases2State createState() => _coronaCases2State(coronaDetails,index);
}

class _coronaCases2State extends State<coronaCases2> {
  var coronaDetails;
  int index;
  _coronaCases2State(this.coronaDetails,this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network('https://logistyx.com/wp-content/uploads/2020/02/retailers-supply-chain-coronavirus.png',fit: BoxFit.cover,
              color: Color(0xff003333).withOpacity(0.7),
              colorBlendMode: BlendMode.darken,),
            Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                        height: MediaQuery.of(context).size.height*0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 10,),
                            Image.network("https://www.countryflags.io/"+coronaDetails["Countries"][index]["CountryCode"]+"/flat/48.png",fit: BoxFit.fitWidth,),
                            SizedBox(width: 20,),
                            Expanded(child: Text(coronaDetails["Countries"][index]["Country"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),))
                          ],
                        )
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.15,
                      child: Column(
                        children: <Widget>[
                          Container(child: Text('Last Updated'),margin: EdgeInsets.only(bottom: 6),),
                          Text(coronaDetails["Countries"][index]["Date"].split("T")[0],style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ),
                  SliverGrid.count(
                    crossAxisCount:2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.0,
                    children: <Widget>[
                      Container(
                          child: Column(
                            children: <Widget>[
                              Container(child: Text('Total Confirmed'),margin: EdgeInsets.only(bottom: 6.0),),
                              Text(coronaDetails["Countries"][index]["TotalConfirmed"].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          )
                      ),
                      Container(
                          child: Column(
                            children: <Widget>[
                              Container(child: Text('New Confirmed'),margin: EdgeInsets.only(bottom: 6.0),),
                              Text(coronaDetails["Countries"][index]["NewConfirmed"].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          )
                      ),
                      Container(
                          child: Column(
                            children: <Widget>[
                              Container(child: Text('Total Deaths'),margin: EdgeInsets.only(bottom: 6.0),),
                              Text(coronaDetails["Countries"][index]["TotalDeaths"].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          )
                      ),
                      Container(
                          child: Column(
                            children: <Widget>[
                              Container(child: Text('New Deaths'),margin: EdgeInsets.only(bottom: 6.0),),
                              Text(coronaDetails["Countries"][index]["NewDeaths"].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          )
                      ),
                      Container(
                          child: Column(
                            children: <Widget>[
                              Container(child: Text('Total Recovered'),margin: EdgeInsets.only(bottom: 6.0),),
                              Text(coronaDetails["Countries"][index]["TotalRecovered"].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          )
                      ),
                      Container(
                          child: Column(
                            children: <Widget>[
                              Container(child: Text('New Recovered'),margin: EdgeInsets.only(bottom: 6.0),),
                              Text(coronaDetails["Countries"][index]["NewRecovered"].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          )
                      ),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                        [
                          pie(coronaDetails,index)
                        ]
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}
class pie extends StatefulWidget {
  var coronaDetails;
  var index;
  pie(this.coronaDetails,this.index);
  @override
  _pieState createState() => _pieState(coronaDetails,index);
}

class _pieState extends State<pie> {
  var coronaDetails;
  var index;
  _pieState(this.coronaDetails,this.index);
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.red,
    Colors.green,
  ];


  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Total Deaths", () => ((coronaDetails["Countries"][index]["TotalDeaths"])/(coronaDetails["Countries"][index]["TotalConfirmed"]))*100);
    dataMap.putIfAbsent("Total Recovered", () => ((coronaDetails["Countries"][index]["TotalRecovered"])/(coronaDetails["Countries"][index]["TotalConfirmed"]))*100);
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32.0,
        chartRadius: MediaQuery.of(context).size.width / 2.7,
        showChartValuesInPercentage: true,
        showChartValues: true,
        showChartValuesOutside: false,
        chartValueBackgroundColor: Colors.grey[200],
        colorList: colorList,
        showLegends: true,
        legendPosition: LegendPosition.right,
        decimalPlaces: 1,
        showChartValueLabel: true,
        initialAngle: 0,
        chartValueStyle: defaultChartValueStyle.copyWith(
          color: Colors.blueGrey[900].withOpacity(0.9),
        ),
        chartType: ChartType.disc,
      ),
    );
  }
}
