import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ohc_app/get_data.dart';

class GraphContainer extends StatefulWidget
{
  final GlobalKey key = new GlobalKey();
  final ReportData reportData;
  static Map<int,List<Session>> data;
  final String firstString;
  final String secondString;
  final String thirdString;
  final String fourthString;
  final IconData firstIcon;
  final int graphType;

  GraphContainer(
  {
  this.reportData,
  this.firstString,
  this.secondString,
  this.thirdString,
  this.fourthString,
  this.firstIcon,
  this.graphType
  });

  @override
  _GraphContainer createState()=> _GraphContainer(reportData: this.reportData,
    firstString: firstString,
    secondString: secondString,
    thirdString:thirdString,
    fourthString:fourthString,
    firstIcon:firstIcon,
    graphType: graphType,
  );
}

class _GraphContainer extends State<GraphContainer>
{
  final ReportData reportData;
  static Map<int,List<Session>> data;
  final String firstString;
  final String secondString;
  final String thirdString;
  final String fourthString;
  final IconData firstIcon;
  final int graphType;

  _GraphContainer(
      {
        this.reportData,
        this.firstString,
        this.secondString,
        this.thirdString,
        this.fourthString,
        this.firstIcon,
        this.graphType,
      }
  );

  void getData()
  {

    data = new Map<int,List<Session>>();
    int iterator;

    Day lastDate = reportData.days[reportData.days.length-1];
    int lastWeekDay = DateTime.parse(lastDate.date).weekday%7;
    for(iterator =(lastWeekDay+1)%7;;)
    {
         data[iterator]=[];
         if(iterator==lastWeekDay)
           break;
         iterator=(iterator+1)%7;
    }
    for(var i in reportData.days )
    {
      int day = DateTime.parse(i.date).weekday%7;
      for(Session j in i.sessions) {
        data[day].add(j);
      }
    }
  }


  @override
  Widget build(BuildContext context)
  {
    getData();
    return(
        Container( //padding: EdgeInsets.only(top: 20,bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(firstString,
                    textAlign:TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                    ),),
                  Text(secondString,
                    style: TextStyle(
                      color: Colors.grey,
                    ),)
                ],
              ),

              Row(
                children: <Widget>[
                  Icon(firstIcon),
                  Text(
                    thirdString,
                    style: TextStyle(
                        fontSize: 40
                    ),
                  ),
                  Text(
                    fourthString,
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),

                ],
              ),

              //Text('min',style: TextStyle(color: Colors.grey),),

              (graphType==1?BarGraph(data:data):IconGraph(data: data)),

              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Icon(
                            Icons.tag_faces
                        ),
                        Text('good')
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Icon(
                            Icons.tag_faces
                        ),
                        Text('too hard')
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Icon(
                            Icons.tag_faces
                        ),
                        Text('n/a')
                      ],
                    ),
                  ),

                ],
              )
            ],
          ),
        )
    );
  }

}

class IconGraph extends StatelessWidget
{
  final Map<int,List<Session>> data;
  IconGraph({this.data});
  Widget iconBar(int a, String day)
  {
    List<Widget> iconList = new List<Widget>();
    double size = 40;
    if(a==0)
      {
        iconList.add(
          Container(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.remove, size: size)
          ),
        );
        iconList.add(
          Container(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.remove, size: size)
          ),
        );
      }
    else if(a==1)
    {
      iconList.add(
        Container(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.remove, size: size)
        ),
      );
      iconList.add(
        Container(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.add, size: size)
        ),
      );

    }
    else if(a>=2) {
      for (int i = 0; i < a; i++) {
        iconList.add(
          Container(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.add, size: size)
          ),
        );
      }
    }

    iconList.add(
        Container(
          padding:const EdgeInsets.only(top: 10,left: 15),
          child:Text(day,),)
    );
    return( new Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisSize: MainAxisSize.min,
        children: iconList,
      ),
    )
    );
  }

  List<Widget> graphBuilder()
  {
    List<Widget> widgets = new List<Widget>();
    List<String> day = ['S','M','T','W','T','F','S'];
    var order = data.keys ;

    for(int i in order)
    {

      widgets.add(new Expanded(child:iconBar(data[i].length,day[i])));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context)
  {
    return(Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: graphBuilder(),
    ));
  }
}



class BarGraph extends StatelessWidget
{
  final Map<int,List<Session>> data;
  BarGraph({this.data});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
            child:
            Container(
              height: 300,
              child: GroupedBarChart.withData(data),
            )
        )

      ],
    );
  }
}


class BrushTime{
  final String day;
  final int minute;
  BrushTime(this.day,this.minute);
}

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;


  GroupedBarChart(this.seriesList, {this.animate});

  factory GroupedBarChart.withData(Map<int,List<Session>> data) {
    return new GroupedBarChart(
      _createData(data),
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
        seriesList,
        animate: animate,


        barGroupingType: charts.BarGroupingType.grouped,
        defaultRenderer: new charts.BarRendererConfig(

            cornerStrategy: const charts.ConstCornerStrategy(30)),
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
              dataIsInWholeNumbers: true,
              desiredTickCount: 4),
          renderSpec: charts.GridlineRendererSpec(
            lineStyle: charts.LineStyleSpec(
              dashPattern: [4,4 ],
            ),),));
  }

  /// Create series list with multiple series

  static List<BrushTime> getSeries(Map<int,List<Session>> data,int sessionNo)//0,1
  {
    List<String> days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
    List<BrushTime> x = new List<BrushTime>();
    var order = data.keys;
    for(var i in order)
      {
        if(data[i].length>sessionNo)
          x.add(BrushTime(days[i], data[i][sessionNo].data.toInt()));
        else
          x.add(BrushTime(days[i], 0));
      }


    return x;

  }
  static List<charts.Series<BrushTime, String>> _createData(Map<int,List<Session>> data) {


    List<List<BrushTime>> series = new List<List<BrushTime>>();
    List<charts.Series<BrushTime, String>> graphData = new List<charts.Series<BrushTime, String>>();


    int max = 0;
    var order = data.keys;
    for(var i in order)
    {
      if(data[i].length>max)
        max = data[i].length;
    }

    for(var i=0;i<max;i++)
    {
      series.add(getSeries(data,i));//0,1
    }
    int cnt=0;

    for(var i in series)
    {
      graphData.add(
        new charts.Series<BrushTime, String>(
          id: 'session'+cnt.toString(),
          domainFn: (BrushTime brush, _) => brush.day,
          measureFn: (BrushTime brush, _) => brush.minute,
          data: i,
          colorFn: (_,__) => (cnt==1)?charts.MaterialPalette.gray.shadeDefault.lighter:charts.MaterialPalette.green.shadeDefault.lighter,
          fillColorFn: (_, __) =>(cnt==1)?
          charts.MaterialPalette.gray.shadeDefault.lighter:charts.MaterialPalette.green.shadeDefault.lighter,
        ),
      );
      cnt++;
    }
  return graphData;


  }
}