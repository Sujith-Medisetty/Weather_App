import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'coronaCases.dart';
class coronaVirus extends StatelessWidget {
  var worldCorona;
  coronaVirus(this.worldCorona);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: coronaVirusStateFull(worldCorona),
    );
  }
}

class coronaVirusStateFull extends StatefulWidget {
  var worldCorona;
  coronaVirusStateFull(this.worldCorona);
  @override
  _coronaVirusStateFullState createState() => _coronaVirusStateFullState(worldCorona);
}

class _coronaVirusStateFullState extends State<coronaVirusStateFull> {
  var worldCorona;
  var coronaDetails;
  var country;
  var code;
  List<String> countries=[];
  Map countriesMap={};
  _coronaVirusStateFullState(this.worldCorona);

  void initState(){
    coronaDetails=worldCorona;
    print(coronaDetails);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.vpn_lock,color: Colors.black,),
        centerTitle:true,
        title: Marquee(child: Text('WorldWide Covid19 Cases',style: TextStyle(color:Colors.black),)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(color:Colors.black54,icon: Icon(Icons.search),onPressed: (){
            showSearch(context: context, delegate: datesearch(countries,countriesMap,coronaDetails));
          },)
        ],),
        body:Container(
            padding: EdgeInsets.only(top:10,bottom: 10),
            child:CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context,index){
                      if(index==0){
                        countries=[];
                        countriesMap={};
                        var len= coronaDetails["Countries"].length;
                        print(len);
                        for(var i=0;i<len;i++){
                          countriesMap[coronaDetails["Countries"][i]["Country"]]=i;
                          countries.add(coronaDetails["Countries"][i]["Country"]);
                        }
                        print('length is'+countries.length.toString());
                      }

                      country=coronaDetails["Countries"][index]["Country"];
                      code=coronaDetails["Countries"][index]["CountryCode"];
                      return Card(
                        color: Colors.black54,
                        elevation: 5.0,
                        child: Container(
                            child:GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (BuildContext context) => coronaCases(worldCorona,index)));
                              },
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Image.network("https://www.countryflags.io/"+ code+"/flat/64.png",fit: BoxFit.fitWidth,
                                    color: Color(0xff003333).withOpacity(0.7),
                                    colorBlendMode: BlendMode.darken,),
                                  Center(child: Text(country,style: TextStyle(color: Colors.white),),)
                                ],
                              ),
                            )
                        ),
                      );
                    },
                    childCount: coronaDetails["Countries"].length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 0,
                    childAspectRatio: 2,
                  ),
                )
              ],
            )
        ),
    );
  }
}

class datesearch extends SearchDelegate<String> {
  List<String> countries;
  Map countriesMap;
  var coronaDetails;
  var index2;
  datesearch(this.countries,this.countriesMap,this.coronaDetails);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = "";
      },)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return coronaCases(coronaDetails,countriesMap[coronaDetails["Countries"][index2]["Country"]]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggessionsList=countries.where((i)=>i.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context,index){
        return ListTile(
          onTap: (){
            showResults(context);
            index2=countriesMap[suggessionsList[index]];
          },
          title: Text(suggessionsList[index],style: TextStyle(color: Colors.black54),),
        );
      },
      itemCount: suggessionsList.length,
    );

  }

}


