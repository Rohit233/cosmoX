class RocketModel {
  late String _id;
  late String _description;
  late String _wikipedia;
  late String _company;
  late String _country;
  late String _firstFlight;
  late int _successRatePct;
  late int _costPerLaunch;
  late int _boosters;
  late int _stages;
  late bool _active;
  late String _type;
  late String _name;
  late List _flickrImages = [];
  late List<PayloadWeight> _payloadWeights = [];
  late LandingLegs _landingLegs;
  late Height _height;
  late Diameter _diameter;
  late Mass _mass;

  String get id => this._id;

  set id(String id) => this._id = id;

  String get description => this._description;

  set description(String description) => this._description = description;

  String get wikipedia => this._wikipedia;

  set wikipedia(String wikipedia) => this._wikipedia = wikipedia;

  String get company => this._company;

  set company(String company) => this._company = company;

  String get country => this._country;

  set country(String country) => this._country = country;

  String get firstFlight => this._firstFlight;

  set firstFlight(String firstFlight) => this._firstFlight = firstFlight;

  int get successRatePct => this._successRatePct;

  set successRatePct(int successRatePct) =>
      this._successRatePct = successRatePct;

  int get costPerLaunch => this._costPerLaunch;

  set costPerLaunch(int costPerLaunch) => this._costPerLaunch = costPerLaunch;

  int get boosters => this._boosters;

  set boosters(int boosters) => this._boosters = boosters;

  int get stages => this._stages;

  set stages(int stages) => this._stages = stages;

  bool get active => this._active;

  set active(bool active) => this._active = active;

  String get type => this._type;

  set type(String type) => this._type = type;

  String get name => this._name;

  set name(String name) => this._name = name;

  List get flickrImages => this._flickrImages;

  set flickrImages(List flickrImages) => this._flickrImages = flickrImages;

  List<PayloadWeight> get payloadWeights => this._payloadWeights;

  set payloadWeights(List<PayloadWeight> payloadWeights) =>
      this._payloadWeights = payloadWeights;

  LandingLegs get landingLegs => this._landingLegs;

  set landingLegs(LandingLegs landingLegs) => this._landingLegs = landingLegs;

  Height get height => this._height;

  set height(Height height) => this._height = height;

  Diameter get diameter => this._diameter;

  set diameter(Diameter diameter) => this._diameter = diameter;

  Mass get mass => this._mass;

  set mass(Mass mass) => this._mass = mass;

  RocketModel getRocketModelObject(data) {
    RocketModel rocketModel = RocketModel();
    rocketModel.id = data['id'];
    rocketModel.description = data['description'];
    rocketModel.wikipedia = data['wikipedia'];
    rocketModel.company = data['company'];
    rocketModel.country = data['country'];
    rocketModel.firstFlight = data['first_flight'];
    rocketModel.successRatePct = data['success_rate_pct'];
    rocketModel.costPerLaunch = data['cost_per_launch'];
    rocketModel.boosters = data['boosters'];
    rocketModel.stages = data['stages'];
    rocketModel.active = data['active'];
    rocketModel.type = data['type'];
    rocketModel.name = data['name'];
    rocketModel.flickrImages = data['flickr_images'];
    for (var i in data['payload_weights']) {
      rocketModel.payloadWeights.add(PayloadWeight(
        id: i['id'],
        kg: i['kg'],
        lb: i['lb'],
        name: i['name'],
      ));
    }
    rocketModel.landingLegs =
        LandingLegs(number: data['landing_legs']['number'],
         material: data['landing_legs']['material']);
    rocketModel.height = Height(meters: data['height']['meters'],
     feet: data['height']['feet']);
    rocketModel.diameter = Diameter(meters: data['diameter']['meters'],
     feet: data['diameter']['feet']); 
    rocketModel.mass = Mass(kg: data['mass']['kg'],
     lb: data['mass']['lb']); 
    return rocketModel;
  }
}

class Mass {
  late double kg;
  late double lb;
  Mass({required this.kg, required this.lb});
}

class Diameter {
  late double meters;
  late double feet;
  Diameter({required this.meters, required this.feet});
}

class Height {
  late double meters;
  late double feet;
  Height({required this.meters, required this.feet});
}

class LandingLegs {
  late int number;
  late String material;
  LandingLegs({required this.number, required this.material});
}

class PayloadWeight {
  late String id;
  late String name;
  late int kg;
  late int lb;
  PayloadWeight(
      {required this.id,
      required this.name,
      required this.kg,
      required this.lb});
}
