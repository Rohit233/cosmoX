class PayloadModel{
  late String? _id;
  late String? _name;
  late bool? _reused;
  late String? _type;
  late double? _lifespanYears;
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

 double? get lifespanYears => this._lifespanYears;

 set lifespanYears(double? lifespanYears) => this._lifespanYears = lifespanYears;

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
   print("id:" +payloadModel.id.toString());
   payloadModel.periapsisKm = data['periapsis_km'];
   print("periapsisKm:"+payloadModel.periapsisKm.toString());
   payloadModel.apoapsisKm = data['apoapsis_km'];
   print('apoapsisKm:'+payloadModel.apoapsisKm.toString());
   payloadModel.inclinationDeg = data['inclination_deg'];
   print('Inclination'+data['inclination_deg'].toString());
   payloadModel.lifespanYears = data['lifespan_years'];
   print('LifespanYears:'+payloadModel.lifespanYears.toString());
   payloadModel.massKg = data['mass_kg'];
   print('Mass kg:'+payloadModel.massKg.toString());
   payloadModel.orbit = data['orbit'];
   print('Orbit'+payloadModel.orbit.toString());
   payloadModel.referenceSystem = data['reference_system'];
   print('ReferenceSystem:'+payloadModel.referenceSystem.toString());
   payloadModel.manufacturers = data['manufacturers'];
   print('Manufacturers:'+payloadModel.manufacturers.toString());
   payloadModel.nationalities = data['nationalities'];
   print('Nationalities:'+payloadModel.nationalities.toString());
   payloadModel.customers = data['customers'];
   print('Customers:'+payloadModel.customers.toString());
   payloadModel.reused = data['reused'];
   print('Reused:'+payloadModel.reused.toString());
   payloadModel.type = data['type'];
   print('type:'+payloadModel.type.toString());
   payloadModel.name = data['name'];
   print('Name:'+payloadModel.name.toString());
   return payloadModel;

 }

}