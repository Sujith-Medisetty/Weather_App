import 'package:flutter/material.dart';
class one extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('second Screen'),
              MaterialButton(
                child:Text('third screen'),
                onPressed: (){

                },
              )
            ],
          ),
        ) ,
      ),
    );
  }

}
