import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphContainer extends StatelessWidget
{
  final List<List<int>> data;
  final String firstString;
  final String secondString;
  final String thirdString;
  final String fourthString;
  final IconData firstIcon;
  final int graphType;

  GraphContainer({this.data,this.firstString,this.secondString,this.thirdString,this.fourthString,this.firstIcon,this.graphType});

  @override
  Widget build(BuildContext context)
  {
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
                  Text(thirdString,style: TextStyle(fontSize: 40),),
                  Text(fourthString,style: TextStyle(color: Colors.grey),),

                ],
              ),

              //Text('min',style: TextStyle(color: Colors.grey),),

              (graphType==1?BarGraph(data: data,):IconGraph(data: data,)),

              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.tag_faces),
                        Text('good')
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.tag_faces),
                        Text('too hard')
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.tag_faces),
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
  Widget iconBar(IconData a, IconData b, String day)
  {
    double size = 40;
    return( new Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(10),
              child: Icon(a,size: size,)
          ),
          Container(
              padding: const EdgeInsets.all(10),
              child: Icon(b,size: size)
          ),
          Container(
            padding:const EdgeInsets.only(top: 10,left: 15),
            child:Text(day,),)
          ,
        ],
      ),
    )
    );
  }

  List<Widget> graphBuilder()
  {
    List<Widget> widgets = new List<Widget>();
    var a,b;
    List<String> day = ['S','M','T','W','T','F','S'];
    for(var i=0;i<this.data.length;i++)
    {
      if(data[i][0]==1)
        a = Icons.plus_one;
      else
        a = Icons.star;
      if(data[i][1]==0)
        b = Icons.plus_one;
      else
        b = Icons.star;
      widgets.add(new Expanded(child:iconBar(a,b,day[data[i][2]])));
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

class BarGraph extends StatefulWidget {
  final List<List<int>> data;
  BarGraph({this.data,Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BarGraphState createState() => _BarGraphState();
}
class BrushTime {
  String x;
  double y;
  BrushTime(this.x,this.y); //constructor
}

class _BarGraphState extends State<BarGraph> {
  List<BrushTime> getColumnData(){
    List<BrushTime> data1 =<BrushTime>[
      BrushTime("Mo",30),
      BrushTime("Tu",30),
      BrushTime("We",30),
      BrushTime("Th",30),
      BrushTime("Fr",30),
      BrushTime("Sa",30),
      BrushTime("So",30),

    ];
    return data1;
  }
  List<BrushTime> getColumnData1(){
    List<BrushTime> data1 =<BrushTime>[
      BrushTime("Mo",30),
      BrushTime("Tu",30),
      BrushTime("We",30),
      BrushTime("Th",30),
      BrushTime("Fr",30),
      BrushTime("Sa",30),
      BrushTime("So",30),

    ];
    return data1;
  }
  @override
  Widget build(BuildContext context) {
    return(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    title: AxisTitle()
                ), //String
                primaryYAxis: NumericAxis(
                    title: AxisTitle()
                ),  //double

                series: <ChartSeries>[
                  ColumnSeries<BrushTime,String>(
                    name: "Brush Time",
                    dataSource: getColumnData(),
                    xValueMapper: (BrushTime brush,_)=> brush.x, //mapping the Values
                    yValueMapper: (BrushTime brush,_)=> brush.y,
                    width: 1,
                    spacing: 0.5,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true),

                  ),
                  ColumnSeries<BrushTime,String>(
                    name: "120 Seconds",
                    dataSource: getColumnData1(),
                    xValueMapper: (BrushTime brush,_)=> brush.x, //mapping the Values
                    yValueMapper: (BrushTime brush,_)=> brush.y,
                    width: 1,
                    spacing: 0.5,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}