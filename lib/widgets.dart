import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
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
        Container(padding:const EdgeInsets.only(top: 8),
          child:RichText(
            text: TextSpan(style: TextStyle(
                color: Colors.black, fontSize: 16),
                children:<TextSpan>[
                  TextSpan(
                      text:"Here's what your oral care looked like this week, from "),
                  TextSpan(
                      text: weekString,style: TextStyle(fontWeight: FontWeight.bold))]),
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
          customIcon(Icons.looks_two,iconSize,'Daily'),
          customIcon(Icons.timelapse,iconSize,'Time'),
          customIcon(Icons.pool,iconSize,'Pressure'),
          customIcon(Icons.brush,iconSize,'Scrubbing'),
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

  Widget fourth(BuildContext context) => Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
            ),
            color: Colors.grey.shade300,
            label: Text('Best way to brush'),
            icon: Icon(Icons.lightbulb_outline),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Second()));
            },
          ),
        ],
      )
  );
class Second extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      appBar: AppBar(
//        title: Text(''),
//      ),
      body: Container(
          child:Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 25),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: Icon( Icons.close),
                          onPressed:(){ Navigator.pop(context);}
                      ),
                    ]
                ),
                Container(
                  padding: EdgeInsets.only(top:10, left: 20),
                  child: Text(
                    'Best way to brush',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,top:10,bottom: 20),
                  child: Text(
                    'To get the most out of your brushing, follow these simple rules',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,

                    ),
                  ),
                ),
                Dash(length: 450,dashColor: Colors.grey.shade300,),
                Container(
                  padding: EdgeInsets.only(top:10, left: 20),
                  child: FlatButton.icon(
                    shape: CircleBorder(),

                    label: Text('Daily brushing average :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    icon: Icon(Icons.looks_two),
                    onPressed: (){},
                  ),
                ),
                Container( padding: EdgeInsets.only(left: 60,right: 10,bottom: 20),
                  child: Text(
                    'Brushing at least 2X per day is the best way to remove unwanted plaque and keep your teeth clean and white',
                    style: TextStyle(
                      fontSize: 15,
                    ),

                  ),
                ),
                Dash(length: 450,dashColor: Colors.grey.shade300,),
                Container(
                  padding: EdgeInsets.only(top:10, left: 20),
                  child: FlatButton.icon(
                    shape: CircleBorder(),

                    label: Text('Brushing time average :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    icon: Icon(Icons.timelapse),
                    onPressed: (){},
                  ),
                ),
                Container( padding: EdgeInsets.only(left: 60,right: 20,bottom: 40,),
                  child: Text(
                    'Brush your teeth for at least 2 minutes per brushing to ensure that every surface tooth has been thoroughly cleaned',
                    style: TextStyle(
                      fontSize: 15,
                    ),

                  ),
                ),
                Dash(length: 450,dashColor: Colors.grey.shade300,),
                Container(
                  padding: EdgeInsets.only(top:20,left: 20),
                  child: FlatButton.icon(
                    shape: CircleBorder(),

                    label: Text('Pressure applied :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    icon: Icon(Icons.brush),
                    onPressed: (){},
                  ),
                ),
                Container( padding: EdgeInsets.only(left: 60,right: 20,bottom: 40,),
                  child: Text(
                    'Very little pressure is needed to brush effectively White brushing,try holding the toothbrush with just your fingertips to maintain a light touch. Your Sonicare will do the work for you',
                    style: TextStyle(
                      fontSize: 15,
                    ),

                  ),
                ),
                Dash(length: 450,dashColor: Colors.grey.shade300,),
                Container(
                  padding: EdgeInsets.only(top:10, left: 20),
                  child: FlatButton.icon(
                    shape: CircleBorder(),

                    label: Text('Scrubbing applied :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    icon: Icon(Icons.scatter_plot),
                    onPressed: (){},
                  ),
                ),
                Container( padding: EdgeInsets.only(left: 60,right: 20,bottom: 40,),
                  child: Text(
                    'Brush your teeth with a small back and forth motion so the bristles reach between the teeth. Continue this motion guiding your brush from tooth to tooth. Avoid scrubbing motoion as it might hurt your gums',
                    style: TextStyle(
                      fontSize: 15,
                    ),

                  ),
                ),
                Dash(length: 450,dashColor: Colors.grey.shade300,),

                Container(color: Colors.grey.shade300,
                  padding: EdgeInsets.only(top:10, left: 20),
                  child: FlatButton.icon(
                    shape: CircleBorder(),

                    label: Text('Please note :                                                                            ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    icon: Icon(Icons.warning),
                    onPressed: (){},
                  ),
                ),
                Container( color: Colors.grey.shade300,
                  padding: EdgeInsets.only(left: 60,right: 20,bottom: 40,),
                  child: Text(
                    'For accurate personalised guidance, be sure to keep your toothbrush connected to the App',
                    style: TextStyle(
                      fontSize: 15,
                    ),

                  ),
                ),


              ]
          )
      ),
    );

  }
}

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

