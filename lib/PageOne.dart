import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
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
    return ListView(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        first(weekString),

        second(iconSize),

        third(),

        fourth(context),

        Dash(length: 410,dashColor: Colors.grey.shade300,),

        GraphContainer(

          reportData:report.data.frequency,
          firstString: 'Brushing daily' ,
          secondString:'average',
          thirdString:report.data.frequency.average.toString(),
          fourthString:'/day',
          firstIcon:Icons.style,
          graphType: 0,),
        Dash(length: 410,dashColor: Colors.grey.shade300,),

      ],
    );

  }
}
