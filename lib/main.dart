import 'package:flutter/material.dart';
import 'widgets.dart';
import 'get_data.dart';
import 'package:ohc_app/Graphs.dart';
import 'package:flutter_dash/flutter_dash.dart';


class MyApp extends StatefulWidget
{
  MyApp({Key key}): super(key:key);

  @override
  _MyApp createState()=> _MyApp();
}

class _MyApp extends State<MyApp>
{
  static double iconSize=80;
  static String weekString ;
  static Report report;
  static JsonDataParser parser ;
  static ListView listObject ;
  ScrollController _controller;
  static Map<int,GlobalKey> keys;
  static double minScroll=40;
  bool custom = false;


  _MyApp()
  {
    dataParsing();
  }

  void scroll()
  {
    //print("Start");
    for(var i in keys.values)
    {
      if(i.currentContext==null)
        continue;

      RenderBox renderBox = i.currentContext.findRenderObject();
      //print(renderBox.localToGlobal(Offset.zero).dy);
      //print(minScroll);
      print(renderBox.localToGlobal(Offset.zero).dy>minScroll);
      if(renderBox.localToGlobal(Offset.zero).dy>=minScroll && renderBox.localToGlobal(Offset.zero).dy<renderBox.size.height) {
        setState(() {
//          _controller.animateTo(_controller.offset + renderBox
//              .localToGlobal(Offset.zero).dy - minScroll,duration: Duration(milliseconds: 200),curve: Curves.linear);
          _controller.jumpTo(_controller.offset + renderBox.localToGlobal(Offset.zero).dy - minScroll);
        });

        break;
      }
    }
    //print('stop');
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
    List<String> months = [
      'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
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
    keys = new Map<int,GlobalKey>();
    _controller = new ScrollController();
    List<Widget> list = <Widget>[
      first(weekString),

      second(iconSize),

      third(),

      fourth(context),

      Dash(dashColor: Colors.green.shade300,),

      GraphContainer(

        reportData:report.data.frequency,
        firstString: 'Brushing daily' ,
        secondString:'average',
        thirdString:report.data.frequency.average.toString(),
        fourthString:'/day',
        firstIcon:Icons.style,
        graphType: 0,),
      Dash(
        length: 300,
        dashColor: Colors.grey.shade300,
      ),

      GraphContainer(reportData:report.data.duration,
        firstString: 'Brushing time' ,
        secondString:'average',
        thirdString:report.data.duration.average.toString(),
        fourthString:'',
        firstIcon:Icons.style,
        graphType: 1,),

      Dash(length: 300,dashColor: Colors.grey.shade300,),

      GraphContainer(reportData:report.data.pressure,
        firstString: 'Pressure applied' ,
        secondString:'',
        thirdString:'too hard',
        fourthString:'',
        firstIcon:Icons.style,
        graphType: 0,),

      Dash(length: 300,dashColor: Colors.grey.shade300,),

      GraphContainer(reportData:report.data.scrubbing,
        firstString: 'Scrubbing applied' ,
        secondString:'',
        thirdString:'good',
        fourthString:'',
        firstIcon:Icons.style,
        graphType: 0,),

      Dash(length: 300,dashColor: Colors.grey.shade300,),

      SizedBox(height: 10),

      ninth(),
    ];
    listObject = new ListView(
        controller: _controller,
        padding: const EdgeInsets.all(10),
        children: list
    );
    keys[0]=list[5].key;
    keys[1] = list[7].key;
    keys[2]=list[9].key;
    keys[3] = list[11].key;

    print(keys);
    return(Scaffold(
      appBar: AppBar(
        title: Center(
            child:Text(
                'Progress')),
      ),
      body:
          Column(
            children: <Widget>[
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  // ignore: missing_return
                  onNotification: (scrollNotification) {
                    if(custom==false && scrollNotification is ScrollEndNotification){
                      if(custom==false)
                        setState(() {
                          custom = true;
                        });

                      scroll();
                      if(custom==true)
                        setState(() {
                          custom = false;
                        });
                    }
                    if(custom==true) {
                      return;
                    }
                    return;
                  },
                  child: listObject,
                ),
              ),
            ]
          )
    ));
  }
}

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Progress',
    home: MyApp(),
  )
  );
}