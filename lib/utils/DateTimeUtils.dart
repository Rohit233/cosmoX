class DateTimeUtils{

  static int getCurrentEpoch(){
    return DateTime.now().millisecondsSinceEpoch;
  }
  static getFormatedDateFromEpoch(int epochTimeStamp){
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epochTimeStamp);
    return dateTime.year.toString()+'-'+dateTime.month.toString()+'-'+dateTime.day.toString();
  }
}