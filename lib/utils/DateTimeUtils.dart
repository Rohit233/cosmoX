class DateTimeUtils{

  static int getCurrentEpoch(){
    return DateTime.now().millisecondsSinceEpoch;
  }
  static String getFormatedDateFromEpoch(int epochTimeStamp){
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epochTimeStamp);
    return dateTime.year.toString()+'-'+dateTime.month.toString()+'-'+dateTime.day.toString();
  }
  static String getFormatedDateTimeFromEpoch(int epochTimeStamp){
     DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epochTimeStamp);
    return dateTime.year.toString()+'-'+dateTime.month.toString()+'-'+dateTime.day.toString()+" - "+ (dateTime.hour <10 ? '0'+dateTime.hour.toString() : dateTime.hour.toString())+":"+(dateTime.minute < 10 ? '0'+dateTime.minute.toString() : dateTime.minute.toString());
  }
}