import 'package:flutter/material.dart';
import 'get_data.dart';
import 'package:ohc_app/Graphs.dart';
import 'package:flutter_dash/flutter_dash.dart';

// ignore: must_be_immutable
class PageTwo extends StatelessWidget{
  Report report;

  PageTwo({this.report});

  @override
  Widget build(BuildContext context) {
    return ListView(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        GraphContainer(reportData:report.data.duration,
          firstString: 'Brushing time' ,
          secondString:'average',
          thirdString:report.data.duration.average.toString(),
          fourthString:'',
          firstIcon:Icons.style,
          graphType: 1,),

        Dash(length: 410,dashColor: Colors.grey.shade300,),

        GraphContainer(reportData:report.data.pressure,
          firstString: 'Pressure applied' ,
          secondString:'',
          thirdString:'too hard',
          fourthString:'',
          firstIcon:Icons.style,
          graphType: 0,),

        Dash(length: 410,dashColor: Colors.grey.shade300,),
      ],
    );

  }
}
