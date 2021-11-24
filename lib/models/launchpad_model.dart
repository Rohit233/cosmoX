class LaunchPadModel{
  late String _id;
  late String _imageUrl;
  late String _name;
  late String _fullName;
  late String _locality;
  late String _region;
  late double _latitude;
  late double _longitude;
  late int _launchAttempts;
  late int _launchSuccesses;
  late List _rockets = [];
  late List _launches = [];
  late String _status;
  late String _details;

 String get id => this._id;

 set id(String id) => this._id = id;

 String get imageUrl => this._imageUrl;

 set imageUrl(String imageUrl) => this._imageUrl = imageUrl;

 String get name => this._name;

 set name(String name) => this._name = name;

 String get fullName => this._fullName;

 set fullName(String fullName) => this._fullName = fullName;

 String get locality => this._locality;

 set locality(String locality) => this._locality = locality;

 String get region => this._region;

 set region(String region) => this._region = region;

 double get latitude => this._latitude;

 set latitude(double latitude) => this._latitude = latitude;

 double get longitude => this._longitude;

 set longitude(double longitude) => this._longitude = longitude;

 int get launchAttempts => this._launchAttempts;

 set launchAttempts(int launchAttempts) => this._launchAttempts = launchAttempts;

 int get launchSuccesses => this._launchSuccesses;

 set launchSuccesses(int  launchSuccesses) => this._launchSuccesses = launchSuccesses;

 List get rockets => this._rockets;

 set rockets(List rockets) => this._rockets = rockets;

 List get launches => this._launches;

 set launches(List launches) => this._launches = launches;

 String get status => this._status;

 set status(String status) => this._status = status;

 String get details => this._details;

 set details(String details) => this._details = details;

 LaunchPadModel getLaunchPadModel(data){
   LaunchPadModel launchPadModel = LaunchPadModel();
   launchPadModel.id = data['id'];
   launchPadModel.details = data['details'];
   launchPadModel.status = data['status'];
   launchPadModel.launches = data['launches'];
   launchPadModel.rockets = data['rockets'];
   launchPadModel.launchSuccesses = data['launch_successes'];
   launchPadModel.launchAttempts = data['launch_attempts'];
   launchPadModel.latitude = data['latitude'];
   launchPadModel.longitude = data['longitude'];
   launchPadModel.region = data['region'];
   launchPadModel.locality = data['locality'];
   launchPadModel.fullName = data['full_name'];
   launchPadModel.name = data['name'];
   launchPadModel.imageUrl = data['images']['large'][0];
   return launchPadModel;
 }

}