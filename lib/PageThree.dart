import 'package:flutter/material.dart';
import 'get_data.dart';
import 'widgets.dart';
import 'package:ohc_app/Graphs.dart';

// ignore: must_be_immutable
class PageThree extends StatelessWidget{
  Report report;

  PageThree({this.report});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GraphContainer(reportData:report.data.scrubbing, firstString: 'Scrubbing applied' , secondString:'',thirdString:'good',fourthString:'',firstIcon:Icons.style,graphType: 0,),
        SizedBox(height: 10),
        ninth(),

      ],
    );

  }
}
