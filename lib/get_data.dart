import 'dart:convert';
import 'package:ohc_app/read_json.dart';

class JsonDataParser
{
  String data;
  Map mapper;



  void loadJsonData(){
    String data = ReadWeeklyData.data;
    mapper = jsonDecode(data);
  }

  String getData(){
    return data;
  }
  Map getMapper(){
    return mapper;
  }

}


class Session
{
  double data;
  String timeStamp;

  Session({this.data,this.timeStamp});

  factory Session.fromJson(Map<String,dynamic> json,int type)
  {
    String dataString;
    switch(type) {
      case 0: dataString = "duration";break;
      case 1: dataString = "frequency";break;
      case 2: dataString = "pressure";break;
      case 3: dataString = "scrubbing";break;
    }
    double d = (type==1?0.0:json[dataString].toDouble());
    return Session(
        data: d,
        timeStamp: json['timeStamp']
    );
  }
}

class Day
{
  String date;
  List<Session> sessions;
  void show()
  {
    print("This is the show function of Day class");
    print(date);
    print(sessions.length);
    print("Till here");
  }
  Day({this.date,this.sessions});

  factory Day.fromJson(Map<String,dynamic> json,int type)
  {

    var list = json['sessions'] as List;
    List<Session> sessionList = list.map((i)=>Session.fromJson(i,type)).toList();
    return Day(
        date: json['day'],
        sessions: sessionList
    );
  }
}

class ReportData
{
  List<Day> days;
  double average;

  ReportData({this.days,this.average});

  factory ReportData.fromJson(Map<String,dynamic> json,int type)
  {
    String prefix,suffix;
    switch(type) {
      case 0 : prefix = "duration";suffix = "brushingDetails";break;
      case 1 : prefix = "frequency";suffix="brushingFrequency";break;
      case 2 : prefix = "pressure";suffix="pressureData";break;
      case 3 : prefix = "scrubbing";suffix="scrubbingData";break;
    }
    String dayDetails = prefix+"DayDetails";
    String avgValue = prefix+"AvgValue";

    var list = json[prefix][suffix][dayDetails] as List;

    List<Day> dayList = list.map((i) => Day.fromJson(i, type)).toList();

    return ReportData(
        days:dayList,
        average: json[prefix][suffix][avgValue].toDouble()
    );

  }
}


class Data
{
  String lastSessionTime;
  String lastSessionDate;
  String reportStartDate;
  String reportEndDate;
  ReportData duration;
  ReportData pressure;
  ReportData frequency;
  ReportData scrubbing;

  Data(
        {
          this.lastSessionTime,
          this.lastSessionDate,
          this.reportStartDate,
          this.reportEndDate,
          this.duration,
          this.frequency,
          this.pressure ,
          this.scrubbing
        }
      );

  factory Data.fromJson(Map<String,dynamic> json)
  {
    return Data(
        lastSessionTime: json['lastSessionTime'],
        lastSessionDate: json['lastSessionDate'],
        reportStartDate: json['reportStartDate'],
        reportEndDate: json['reportEndDate'],
        duration:ReportData.fromJson(json['reportData'],0),
        frequency: ReportData.fromJson(json['reportData'],2),
        pressure: ReportData.fromJson(json['reportData'],1),
        scrubbing:ReportData.fromJson(json['reportData'],3)
    );
  }
}

class Report
{
  String screenType;
  Data data;

  Report({this.screenType,this.data});

  factory Report.fromJson(Map<String,dynamic> json)
  {
    if(json['data']==null)
      return(
          Report(
              screenType: json['screenType'],
              data:null
          )
      );
    return Report(
        screenType: json['screenType'],
        data: Data.fromJson(json['data'])
    );
  }
}