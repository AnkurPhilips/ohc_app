import 'package:flutter/material.dart';
import 'Graphs.dart';
import 'get_data.dart';
import 'Time.dart';
class MyApp extends StatelessWidget
{

  static double iconSize = 80;

  static Widget customIcon(IconData icon, double size,  String data){
    return(Column(
      children: <Widget>[
        Icon(icon, size: size, color: Colors.indigo, ),
        Container(padding: const EdgeInsets.only(top: 5),child: Text(data, ))
      ],
    )
    );
  }


  final Widget first = Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Text('Hi Jane,',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        Container(padding:const EdgeInsets.only(top: 8),child:RichText(text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 16),children:<TextSpan>[TextSpan(text:"Here's what your oral care looked like this week, from "),
          TextSpan(text: "31 Oct - 6 Nov:",style: TextStyle(fontWeight: FontWeight.bold))]),
          softWrap: true,),
        )],
    ),
  );

  final Widget second = Container(
    padding: const EdgeInsets.only(top: 20,bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        customIcon(Icons.access_alarm,iconSize,'Daily'),
        customIcon(Icons.access_alarm,iconSize,'Time'),
        customIcon(Icons.access_alarm,iconSize,'Pressure'),
        customIcon(Icons.access_alarm,iconSize,'Scrubbing'),
      ],
    ));

  final Widget third = Container(
    decoration: BoxDecoration(
      color: Colors.blueGrey
    ),
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Text('Frequency: Did you know ?',style:TextStyle(
          fontWeight: FontWeight.bold
        ) ),
        Container(padding: const EdgeInsets.only(top: 5),child: Text('Plaque builds up and can harden into tartar within 18 hours. While you remove plaque by brushing, tartar can only be removed by a dntal professional. This is why it is recommended to brush every 12 hours' ,
        softWrap: true,)),
      ],
    ),
  );

  final Widget fourth = Container(
    padding: const EdgeInsets.only(top: 5,bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text('Best way to brush'),
        Icon(Icons.lightbulb_outline)
      ],
    ),
  );

  final Widget ninth = Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.deepPurple,
    ),
    child: Row(
      children: <Widget>[
      Icon(Icons.kitchen,size: 60,),
      Expanded(child: Text('Based on your usage, you have 180 sessions left on your Premium Plaque Control brush head',
        softWrap: true,
        style: TextStyle(color: Colors.white)
      ),),
    ]
    ),
  );

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

    String timeStamp = "2020-02-26T16:32:21+0530";
    TimeZone timeZone = TimeZone(timeStamp);
    //catch(e){print(e);print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");}




    return(Scaffold(
      appBar: AppBar(
        title: Center(child:Text('Progress')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          first,
          SizedBox(height: 10),
          second,
          third,
          fourth,
          GraphContainer(data:data, firstString: 'Brushing daily' , secondString:'average',thirdString:'1.6',fourthString:'/day',firstIcon:Icons.style,graphType: 0,),
          SizedBox(height: 10),
          GraphContainer(data:data, firstString: 'Pressure applied' , secondString:'',thirdString:'too hard',fourthString:'',firstIcon:Icons.style,graphType: 0,),
          SizedBox(height: 10),
          GraphContainer(data:data, firstString: 'Scrubbing applied' , secondString:'',thirdString:'good',fourthString:'',firstIcon:Icons.style,graphType: 1,),
          SizedBox(height: 10),
          GraphContainer(data:data, firstString: 'Scrubbing applied' , secondString:'',thirdString:'good',fourthString:'',firstIcon:Icons.style,graphType: 0,),
          SizedBox(height: 10),
          ninth,

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