import 'package:flutter/material.dart';

Widget customIcon(IconData icon, double size,  String data){
    return(Column(
      children: <Widget>[
        Icon(icon, size: size, color: Colors.indigo, ),
        Container(padding: const EdgeInsets.only(top: 5),child: Text(data, ))
      ],
    )
    );
  }

  Widget first(String weekString) => Container(
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
          TextSpan(text: weekString,style: TextStyle(fontWeight: FontWeight.bold))]),
          softWrap: true,),
        )],
    ),
  );

  Widget second(double iconSize) => Container(
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

  Widget third() => Container(
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

  Widget fourth() => Container(
    padding: const EdgeInsets.only(top: 5,bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text('Best way to brush'),
        Icon(Icons.lightbulb_outline)
      ],
    ),
  );

  Widget ninth() => Container(
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

