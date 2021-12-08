class PayloadModel{
  late String? _id;
  late String? _name;
  late bool? _reused;
  late String? _type;
  late int? _lifespanYears;
  late double? _periapsisKm;
  late double? _apoapsisKm;
  late double? _inclinationDeg;
  late String? _referenceSystem;
  late int? _massKg;
  late String? _orbit;
  late List? _customers = [];
  late List? _nationalities = [];
  late List? _manufacturers = [];
  String? get id => this._id;

 set id(String? id) => this._id = id;

 String? get name => this._name;

 set name(String? name) => this._name = name;

 bool? get reused => this._reused;

 set reused(bool? reused) => this._reused = reused;

 String? get type => this._type;

 set type(String? type) => this._type = type;

 int? get lifespanYears => this._lifespanYears;

 set lifespanYears(int? lifespanYears) => this._lifespanYears = lifespanYears;

 double? get periapsisKm => this._periapsisKm;

 set periapsisKm(double? periapsisKm) => this._periapsisKm = periapsisKm;

 double? get apoapsisKm => this._apoapsisKm;

 set apoapsisKm(double? apoapsisKm) => this._apoapsisKm = apoapsisKm;

 double? get inclinationDeg => this._inclinationDeg;

 set inclinationDeg(double? inclinationDeg) => this._inclinationDeg = inclinationDeg;

 String? get referenceSystem => this._referenceSystem;

 set referenceSystem(String? referenceSystem) => this._referenceSystem = referenceSystem;

 int? get massKg => this._massKg;

 set massKg(int? massKg) => this._massKg = massKg;

 String? get orbit => this._orbit;

 set orbit(String? orbit) => this._orbit = orbit;

 List? get customers => this._customers;

 set customers(List? customers) => this._customers = customers;

 List? get nationalities => this._nationalities;

 set nationalities(List? nationalities) => this._nationalities = nationalities;

 List? get manufacturers => this._manufacturers;

 set manufacturers(List? manufacturers) => this._manufacturers = manufacturers;

 PayloadModel getPayloadModelObject(data){
   PayloadModel payloadModel = PayloadModel();
   payloadModel.id = data['id'];
   payloadModel.periapsisKm = data['periapsis_km'];
   payloadModel.apoapsisKm = data['apoapsis_km'];
   payloadModel.inclinationDeg = data['inclination_deg'];
   payloadModel.lifespanYears = data['lifespan_years'];
   payloadModel.massKg = data['mass_kg'];
   payloadModel.orbit = data['orbit'];
   payloadModel.referenceSystem = data['reference_system'];
   payloadModel.manufacturers = data['manufacturers'];
   payloadModel.nationalities = data['nationalities'];
   payloadModel.customers = data['customers'];
   payloadModel.reused = data['reused'];
   payloadModel.type = data['type'];
   payloadModel.name = data['name'];
   return payloadModel;

 }

}