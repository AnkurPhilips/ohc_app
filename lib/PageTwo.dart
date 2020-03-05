import 'package:flutter/material.dart';
import 'get_data.dart';
//import 'widgets.dart';
import 'package:ohc_app/Graphs.dart';

// ignore: must_be_immutable
class PageTwo extends StatelessWidget{
  Report report;

  PageTwo({this.report});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GraphContainer(reportData:report.data.frequency,
          firstString: 'Brushing daily' ,
          secondString:'',
          thirdString:'good',
          fourthString:'',
          firstIcon:Icons.style,
          graphType: 1,),
        GraphContainer(reportData:report.data.pressure,
          firstString: 'Pressure applied' ,
          secondString:'',
          thirdString:'too hard',
          fourthString:'',
          firstIcon:Icons.style,
          graphType: 0,),


      ],
    );

  }
}
