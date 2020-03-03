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
    print(json);

    String dataString;
    switch(type) {
      case 0: dataString = "duration";break;
      case 1: dataString = "frequency";break;
      case 2: dataString = "pressure";break;
      case 3: dataString = "scrubbing";break;
    }
    double d = (type==1?0.0:json[dataString].toDouble());
    print(d);
    return Session(data: d,timeStamp: json['timeStamp']);
  }
}

class Day
{
  String day;
  List<Session> sessions;

  Day({this.day,this.sessions});

  factory Day.fromJson(Map<String,dynamic> json,int type)
  {
    print("333333333333333333333333333333333333333333333333333333333333333333333333333333");
    print(json);
    var list = json['sessions'] as List;
    List<Session> sessionList = list.map((i)=>Session.fromJson(i,type)).toList();
    return Day(day: json['day'],sessions: sessionList);
  }
}

class ReportData
{
  List<Day> days;
  double average;

  ReportData({this.days,this.average});

  factory ReportData.fromJson(Map<String,dynamic> json,int type)
  {

    print("222222222222222222222222222222222222222222222222222222222222222222222222222222");

    String prefix,suffix;
    switch(type) {
      case 0 : prefix = "duration";suffix = "brushingDetails";break;
      case 1 : prefix = "frequency";suffix="brushingFrequency";break;
      case 2 : prefix = "pressure";suffix="pressureData";break;
      case 3 : prefix = "scrubbing";suffix="scrubbingData";break;
    }
    String dayDetails = prefix+"DayDetails";
    String avgValue = prefix+"AvgValue";

    print(json);

    var list = json[prefix][suffix][dayDetails] as List;

    //print(list);
    List<Day> dayList = list.map((i) => Day.fromJson(i, type)).toList();

    return ReportData(days:dayList,average: json[prefix][suffix][avgValue].toDouble() );

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

  Data({this.lastSessionTime,this.lastSessionDate,this.reportStartDate,this.reportEndDate,this.duration,this.frequency,this.pressure ,this.scrubbing});

  factory Data.fromJson(Map<String,dynamic> json)
  {
    print("111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
    print(json);
    return Data(lastSessionTime: json['lastSessionTime'],lastSessionDate: json['lastSessionDate'],reportStartDate: json['reportStartDate'],reportEndDate: json['reportEndDate'],duration:ReportData.fromJson(json['reportData'],0),frequency: ReportData.fromJson(json['reportData'],2),pressure: ReportData.fromJson(json['reportData'],1),scrubbing:ReportData.fromJson(json['reportData'],3));
  }
}

class Report
{
  String screenType;
  Data data;

  Report({this.screenType,this.data});

  factory Report.fromJson(Map<String,dynamic> json)
  {
    print("00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    print(json);
    if(json['data']==null)
      return(Report(screenType: json['screenType'],data:null));
    return Report(screenType: json['screenType'],data: Data.fromJson(json['data']));
  }
}