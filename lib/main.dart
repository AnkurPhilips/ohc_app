import 'package:flutter/material.dart';
import 'Graphs.dart';
import 'get_data.dart';
import 'progress_report_widgets.dart';
class MyApp extends StatelessWidget
{

  static double iconSize = 80;
  static String weekString;

  static Widget customIcon(IconData icon, double size,  String data){
    return(Column(
      children: <Widget>[
        Icon(icon, size: size, color: Colors.indigo, ),
        Container(padding: const EdgeInsets.only(top: 5),child: Text(data, ))
      ],
    )
    );
  }

  @override
  Widget build(BuildContext context)
  {
    List<List<int>> data = new List();
    data.add([1,1,0]);
    data.add([1,0,1]);
    data.add([1,1,2]);
    data.add([0,1,3]);
    data.add([1,1,4]);
    data.add([1,0,5]);
    data.add([1,1,6]);

    JsonDataParser parser ;

    parser = new JsonDataParser();
    parser.loadJsonData();
    Report report = new Report.fromJson(parser.mapper);
    print(report.data.scrubbing.average);




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