import 'package:flutter/material.dart';
import 'Graphs.dart';
import 'get_data.dart';
import 'widgets.dart';
class MyApp extends StatelessWidget
{

  static double iconSize = 80;
  static String weekString;

  @override
  Widget build(BuildContext context)
  {
    JsonDataParser parser ;
    parser = new JsonDataParser();
    parser.loadJsonData();

    Report report = new Report.fromJson(parser.mapper);

    return(Scaffold(
      appBar: AppBar(
        title: Center(child:Text('Progress')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          first(weekString),
          SizedBox(height: 10),
          second(iconSize),
          third(),
          fourth(),
          GraphContainer(reportData:report.data.duration, firstString: 'Brushing time' , secondString:'average',thirdString:'1.6',fourthString:'/day',firstIcon:Icons.style,graphType: 0,),
          SizedBox(height: 10),
          GraphContainer(reportData:report.data.frequency, firstString: 'Brushing daily' , secondString:'',thirdString:'good',fourthString:'',firstIcon:Icons.style,graphType: 1,),
          SizedBox(height: 10),
          GraphContainer(reportData:report.data.pressure, firstString: 'Pressure applied' , secondString:'',thirdString:'too hard',fourthString:'',firstIcon:Icons.style,graphType: 0,),
          SizedBox(height: 10),
          GraphContainer(reportData:report.data.scrubbing, firstString: 'Scrubbing applied' , secondString:'',thirdString:'good',fourthString:'',firstIcon:Icons.style,graphType: 0,),
          SizedBox(height: 10),
          ninth(),

        ],
      ),
    ));
  }
}

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Progress',
    home: MyApp(),
  ));
}