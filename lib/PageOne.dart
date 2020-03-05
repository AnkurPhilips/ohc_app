import 'package:flutter/material.dart';
import 'get_data.dart';
import 'widgets.dart';
import 'package:ohc_app/Graphs.dart';

// ignore: must_be_immutable
class PageOne extends StatelessWidget{
   String weekString;
   double iconSize;
   Report report;


  PageOne({this.weekString,this.iconSize,this.report});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        first(weekString),
        SizedBox(height: 10),
        second(iconSize),
        third(),
        fourth(),
        GraphContainer(
          reportData:report.data.duration,
          firstString: 'Brushing time' ,
          secondString:'average',
          thirdString:'1.6',
          fourthString:'/day',
          firstIcon:Icons.style,
          graphType: 0,),
        SizedBox(height: 0),

      ],
    );

  }
}
