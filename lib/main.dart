import 'package:flutter/material.dart';
import 'Graphs.dart';
import 'get_data.dart';
import 'progress_report_widgets.dart';

class MyApp extends StatelessWidget
{
  static double iconSize=80;
  static String weekString ;
  static Report report;
  static JsonDataParser parser ;

  static void dataParsing()
  {
    parser = new JsonDataParser();
    parser.loadJsonData();
    report = new Report.fromJson(parser.mapper);
    setWeekString(report);
  }

  static void setWeekString(Report report)
  {
    DateTime startDate = DateTime.parse(report.data.reportStartDate);
    DateTime endDate = DateTime.parse(report.data.reportEndDate);

    int diff = startDate.difference(endDate).inDays;
    List<String> months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    int a,c;
    String b,d;

    if(diff!=7)
      startDate = startDate.subtract(
          new Duration(
              days: 7
          )
      );

    print(startDate);
    print(endDate);
    a = startDate.day;
    b = months[startDate.month+1];
    c = endDate.day;
    d = months[endDate.month+1];
    weekString="$a $b - $c $d :";


  }

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
    //TimeZone timeZone = TimeZone(timeStamp);
    //catch(e){print(e);print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");}

    dataParsing();



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