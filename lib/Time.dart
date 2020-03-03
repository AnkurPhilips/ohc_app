import 'dart:core';
class Date
{
  int day,month,year;

  Date(String date)
  {
    var splitDate = date.split("-");
    day = int.parse(splitDate[0]);
    month = int.parse(splitDate[1]);
    year = int.parse(splitDate[2]);
  }

}

class Time
{
  int hr,min,sec;

  Time(String time)
  {
    var splitTime = time.split('+');
    var splitUTC = splitTime[0].split(':');
    hr = int.parse(splitUTC[0]);
    min = int.parse(splitUTC[1]);
    sec = int.parse(splitUTC[2]);
  }

}

class TimeZone
{
  Date date;
  Time time;

  TimeZone(String timeStamp)
  {
    var dateTime = timeStamp.split('T');
    date = Date(dateTime[0]);
  }
}