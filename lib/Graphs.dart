import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ohc_app/get_data.dart';

class GraphContainer extends StatelessWidget
{
  final ReportData reportData;
  static List<List<int>> data;
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
      }
  );

  void getData()
  {
    int day=0;
    data = new List<List<int>>();

    for(var i in reportData.days )
      {
        data.add([]);
        data[day].add(day);
        data[day].add(i.sessions.length);
        day++;
      }
    for(;day<7;day++)
      {
        data.add([]);
        data[day].add(day);
        data[day].add(0);
      }
    print(data);
  }

  @override
  Widget build(BuildContext context)
  {
    try {
      getData();
    }
    catch(e)
    {
      print(e);
    }
    return(
        Container(
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

              (graphType==1?BarGraph():IconGraph(data: data,)),

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
  final List<List<int>> data;
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
    for(var i=0;i<this.data.length;i++)
    {

      widgets.add(new Expanded(child:iconBar(data[i][1],day[data[i][0]])));            //here
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context)
  {
    return(Row(
      children: graphBuilder(),
    ));
  }
}



class BarGraph extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
            child:
            Container(
              height: 300,
              child: GroupedBarChart.withSampleData(),
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

  factory GroupedBarChart.withSampleData() {
    return new GroupedBarChart(
      _createSampleData(),
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return( charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: new charts.BarRendererConfig(

          cornerStrategy: const charts.ConstCornerStrategy(30)),
    ));
  }

  /// Create series list with multiple series
  static List<charts.Series<BrushTime, String>> _createSampleData() {


    final session1 = [

      new BrushTime('Mo', 240),
      new BrushTime('Tu', 225),
      new BrushTime('We', 180),
      new BrushTime('Th', 165),
      new BrushTime('Fr', 195),
      new BrushTime('Sa', 95),
      new BrushTime('So', 100),

    ];

    final session2 = [
      new BrushTime('Mo', 120),
      new BrushTime('Tu', 120),
      new BrushTime('We', 120),
      new BrushTime('Th', 120),
      new BrushTime('Fr', 120),
      new BrushTime('Sa', 120),
      new BrushTime('So', 120),
    ];

    final session3 = [
      new BrushTime('Mo', 235),
      new BrushTime('Tu', 125),
      new BrushTime('We', 100),
      new BrushTime('Th', 175),
      new BrushTime('Fr', 185),
      new BrushTime('Sa', 225),
      new BrushTime('So', 100),
    ];



    return [
      new charts.Series<BrushTime, String>(
        id: 'session1',
        domainFn: (BrushTime brush, _) => brush.day,
        measureFn: (BrushTime brush, _) => brush.minute,
        data: session1,
        colorFn: (_,__) => charts.MaterialPalette.red.shadeDefault,
        fillColorFn: (_, __) =>
        charts.MaterialPalette.red.shadeDefault.lighter,
      ),
      new charts.Series<BrushTime, String>(
        id: 'session2',
        domainFn: (BrushTime brush, _) => brush.day,
        measureFn: (BrushTime brush, _) => brush.minute,
        data: session3,
        colorFn: (_,__) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
        charts.MaterialPalette.blue.shadeDefault.darker,
      ),
      new charts.Series<BrushTime, String>(
        id: 'session3',
        domainFn: (BrushTime brush, _) => brush.day,
        measureFn: (BrushTime brush, _) => brush.minute,
        data: session2,
        colorFn: (_,__) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
        charts.MaterialPalette.blue.shadeDefault.lighter,
      ),

    ];
  }
}