class Date
{
  int day,month,year;

}

class Time
{

}

class TimeZone
{
  Date date;
  Time time;

  TimeZone(String timeStamp)
  {
    var dateTime = timeStamp.split('T');
    print(dateTime[0]);
    print(dateTime[1]);
  }
}