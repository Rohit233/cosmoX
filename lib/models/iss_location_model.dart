class IssLocationModel{
  late double _latitude;
  late double _longitude;
  late double _altitude;
  late double _velocity;
  late String _visibility;
  late double _footPrint;
  late double _dayNum;
  late double _solarLat;
  late double _solarLon;
  late String _units;
  late int _timestamp;

  double get altitude => this._altitude;

 set altitude(double altitude) => this._altitude = altitude;

 double get velocity => this._velocity;

 set velocity(double velocity) => this._velocity = velocity;

 String get visibility => this._visibility;

 set visibility(String visibility) => this._visibility = visibility;

 double get footPrint => this._footPrint;

 set footPrint(double footPrint) => this._footPrint = footPrint;

 double get dayNum => this._dayNum;

 set dayNum(double dayNum) => this._dayNum = dayNum;

 double get solarLat => this._solarLat;

 set solarLat( double solarLat) => this._solarLat = solarLat;

 double get solarLon => this._solarLon;

 set solarLon(double solarLon) => this._solarLon = solarLon;

 String get units => this._units;

 set units(String units) => this._units = units;
  
 double get latitude => this._latitude;

 set latitude(double latitude) => this._latitude = latitude;

 double get longitude => this._longitude;

 set longitude(double longitude) => this._longitude = longitude;

 int get timestamp => this._timestamp;

 set timestamp(int timestamp) => this._timestamp = timestamp;



 IssLocationModel getIssLocationObject(data){
    IssLocationModel issLocationModel = IssLocationModel();
    issLocationModel.timestamp  = data['timestamp'];
    issLocationModel.latitude = data['latitude'];
    issLocationModel.longitude = data['longitude'];
    issLocationModel.altitude = data['altitude'];
    issLocationModel.velocity = data['velocity'];
    issLocationModel.visibility = data['visibility'];
    issLocationModel.footPrint = data['footprint'];
    issLocationModel.dayNum = data['daynum'];
    issLocationModel.solarLat = data['solar_lat'];
    issLocationModel.solarLon = data['solar_lon'];
    issLocationModel.units = data['units'];
    return issLocationModel;
 }

}