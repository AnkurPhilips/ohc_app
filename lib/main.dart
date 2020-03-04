import 'package:flutter/material.dart';
import 'package:ohc_app/PageOne.dart';
import 'get_data.dart';
import 'package:ohc_app/PageTwo.dart';
import 'package:ohc_app/PageThree.dart';
class MyApp extends StatelessWidget
{

  static double iconSize=80;
  static String weekString ;
  static Report report;
  static JsonDataParser parser ;

  MyApp()
  {
    dataParsing();
  }

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

  @override
  Widget build(BuildContext context)
  {
    List <Widget> pages=[
      PageOne(
        weekString: weekString,
        iconSize: iconSize,
        report: report,
      ),
      PageTwo(
        report: report
      ),
    PageThree(
      report: report,
    )];
    return(Scaffold(
      appBar: AppBar(
        title: Center(child:Text('Progress')),
      ),
      body: 
      Container(
        padding: const EdgeInsets.all(10),
        child: 
         PageView(

           children:
               <Widget>
        [
          Container(
            child:pages[0] ,
            padding: EdgeInsets.all(10),
          ),
          Container(
            child: pages[1],
            padding: EdgeInsets.all(10),
          ),
                 Container(
                 child:pages[2] ,
                 padding: EdgeInsets.all(10),
               ),],
          scrollDirection: Axis.vertical,
          pageSnapping: false,
        ),
      )
      )
      );
    }
  }

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Progress',
    home: MyApp(),
  ));
}