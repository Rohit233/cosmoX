class SpaceXLaunchesModel{
  late String? _id;
  late int? _flightNumber;
  late bool? _success;
  late String? _name;
  late String? _smallIcon;
  late String? _rocket;
  late List? _crews = [];
  late List? _ships = [];
  late List? _capsules = [];
  late List? _payloads = [];
  late List<Core>? _cores = [];
  late int? _dateInUnix;
  late bool? _upcoming;
  late String? _webcast;
  late String? _youtubeId;
  late String? _article;
  late String? _wikipedia;
  late int? _staticFireDateUnix;
  late String? _details;
  late List<LaunchFailures>? _failures = [];
  late String? _launchePad;

  String? get id => this._id;

 set id(String? id) => this._id = id;

  int? get flightNumber => this._flightNumber;

 set flightNumber(int? value) => this._flightNumber = value;

 bool? get success => this._success;

 set success(bool? value) => this._success = value;

 String? get name => this._name;

 set name(String? value) => this._name = value;

 String? get smallIcon => this._smallIcon;

 set smallIcon(String? value) => this._smallIcon = value;

 String? get rocket => this._rocket;

 set rocket(String? value) => this._rocket = value;

 List? get crews => this._crews;

 set crews(List? value) => this._crews = value;

 List? get ships => this._ships;

 set ships(List? value) => this._ships = value;

 List? get capsules => this._capsules;

 set capsules(List? value) => this._capsules = value;

 List? get payloads => this._payloads;

 set payloads(List? value) => this._payloads = value;

 List<Core>? get cores => this._cores;

 set cores(List<Core>? value) => this._cores = value;

 int? get dateInUnix => this._dateInUnix;

 set dateInUnix(int? value) => this._dateInUnix = value;

 bool? get upcoming => this._upcoming;

 set upcoming(bool? value) => this._upcoming = value;

 String? get webcast => this._webcast;

 set webcast(String? value) => this._webcast = value;

 String? get youtubeId => this._youtubeId;

 set youtubeId(String? value) => this._youtubeId = value;

 String? get article => this._article;

 set article(String? value) => this._article = value;

 String? get wikipedia => this._wikipedia;

 set wikipedia(String? value) => this._wikipedia = value;

 int? get staticFireDateUnix => this._staticFireDateUnix;

 set staticFireDateUnix(int? value) => this._staticFireDateUnix = value;

 String? get details => this._details;

 set details(String? value) => this._details = value;

 List<LaunchFailures>? get failures => this._failures;

 set failures( List<LaunchFailures>?value) => this._failures = value;

 String? get launchePad => this._launchePad;

 set launchePad(String? value) => this._launchePad = value;


  static SpaceXLaunchesModel getSpaceXLaunchObject(data){
    SpaceXLaunchesModel spaceXLaunchesModel = SpaceXLaunchesModel();
    spaceXLaunchesModel.id  = data['id'];
    spaceXLaunchesModel.flightNumber  = data['flight_number'];
    spaceXLaunchesModel.dateInUnix  = data['date_unix'];
    spaceXLaunchesModel.upcoming  = data['upcoming'];
    spaceXLaunchesModel.name = data['name'];
    spaceXLaunchesModel.crews!.addAll(data['crew']);
    spaceXLaunchesModel.ships!.addAll(data['ships']);
    spaceXLaunchesModel.capsules!.addAll(data['capsules']);
    spaceXLaunchesModel.payloads!.addAll(data['payloads']);
    spaceXLaunchesModel.launchePad = data['launchpad'];
    spaceXLaunchesModel.rocket = data['rocket'];
    spaceXLaunchesModel.webcast = data['webcast'];
    spaceXLaunchesModel.youtubeId = data['youtube_id'];
    spaceXLaunchesModel.article = data['article'];
    spaceXLaunchesModel.wikipedia = data['wikipedia'];
    spaceXLaunchesModel.staticFireDateUnix = data['static_fire_date_unix'];
    spaceXLaunchesModel.success = data['success'];
    spaceXLaunchesModel.details = data['details'];
    spaceXLaunchesModel.smallIcon = data['links']['patch']['large'];

    for(var failure in data['failures']){
      spaceXLaunchesModel.failures!.add(LaunchFailures(
        altitude: failure['altitude'],
        reason: failure['reason'],
        time: failure['time']
      ));
    }

    for(var core in data['cores']){
      spaceXLaunchesModel.cores!.add(Core(coreId: core['core'],
       flight: core['flight'],
       gridfins: core['gridfins'],
       legs: core['legs'],
       reused: core['reused'],
       landingAttempt: core['landing_attempt'],
       landingSuccess: core['landing_success'],
       landingType: core['landing_type'],
       landingPad: core['landpad']));
    }
    return spaceXLaunchesModel;
  }

}

class LaunchFailures{
  late int? time;
  late int? altitude;
  late String? reason;
  LaunchFailures({required this.time,required this.altitude,required this.reason});
}
class Core{
  late String? coreId;
  late int? flight;
  late bool? gridfins;
  late bool? legs;
  late bool? reused;
  late bool? landingAttempt;
  late bool? landingSuccess;
  late String? landingType;
  late String? landingPad;
  Core({required this.coreId,
  required this.flight,
  required this.gridfins,
  required this.legs,
  required this.reused,
  required this.landingAttempt,
  required this.landingSuccess,
  required this.landingType,
  required this.landingPad,
  });
}