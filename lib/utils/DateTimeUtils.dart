class DateTimeUtils{

  static int getCurrentEpoch(){
    return DateTime.now().millisecondsSinceEpoch;
  }
  static String getFormatedDateFromEpoch(int epochTimeStamp){
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epochTimeStamp);
    return dateTime.year.toString()+'-'+ '${dateTime.month < 10 ? 0.toString() + dateTime.month.toString() : dateTime.month.toString()}'+'-'+'${dateTime.day < 10 ? 0.toString() + dateTime.day.toString() : dateTime.day.toString()}';
  }
  static String getFormatedTimeFromEpoch(int epochTimeStamp){
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(epochTimeStamp);
    return (dateTime.hour < 10 ? '0${dateTime.hour.toString()}' : dateTime.hour.toString())
     + ":" + (dateTime.minute < 10 ? '0${dateTime.minute.toString()}' : dateTime.minute.toString());
  }
  static String getFormatedDateTimeFromEpoch(int epochTimeStamp){
     DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epochTimeStamp);
    return dateTime.year.toString()+'-'+dateTime.month.toString()+'-'+dateTime.day.toString()+" - "+ (dateTime.hour <10 ? '0'+dateTime.hour.toString() : dateTime.hour.toString())+":"+(dateTime.minute < 10 ? '0'+dateTime.minute.toString() : dateTime.minute.toString());
  }

  // Convert This 2021-11-04T21:16:42.000Z to date
  static DateTime getDateTimeForStringOfDateTime(String dateTimeString){
    List<String> dateTime = dateTimeString.split('T');
    return DateTime.parse(dateTime[0]+' '+dateTime[1].split('Z')[0]);
  }
}