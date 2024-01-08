class PGHostel {
  String name;
  double longitude;
  double latitude;
  String gender;
  String suitedFor;
  String description;
  Map<String, dynamic> photos;
  String contact;
  String email;
  bool laundry;
  bool mess;
  bool cleaning;
  bool waterSupply;
  bool fridge;
  bool gym;
  bool geyser;
  bool gatedCommunity;
  bool waterPurifier;
  bool wifi;
  bool powerBackup;
  bool parking;
  bool tv;
  bool cctv;
  bool lift;
  double singleRent = 0;
  double doubleRent = 0;
  double threePlusRent = 0;
  int threePlusRooms = 0;
  Map<String, dynamic> rules;
  bool isUploadedToDB;

  PGHostel(
      {required this.name,
      required this.longitude,
      required this.latitude,
      required this.gender,
      required this.suitedFor,
      required this.description,
      required this.photos,
      required this.contact,
      required this.email,
      required this.laundry,
      required this.mess,
      required this.cleaning,
      required this.waterSupply,
      required this.fridge,
      required this.gym,
      required this.geyser,
      required this.gatedCommunity,
      required this.waterPurifier,
      required this.wifi,
      required this.powerBackup,
      required this.parking,
      required this.tv,
      required this.cctv,
      required this.lift,
      required this.singleRent,
      required this.doubleRent,
      required this.threePlusRent,
      required this.threePlusRooms,
      required this.rules,
      this.isUploadedToDB = false});

  // Optionally, you can add methods for serialization and deserialization
  // if you need to convert Hostel objects to and from JSON, for example.

  List<String> getFieldNames() {
    return [
      name,
      longitude.toString(),
      latitude.toString(),
      gender,
      suitedFor,
      description,
      photos.toString(),
      contact,
      email,
      laundry.toString(),
      mess.toString(),
      cleaning.toString(),
      waterSupply.toString(),
      fridge.toString(),
      gym.toString(),
      geyser.toString(),
      gatedCommunity.toString(),
      waterPurifier.toString(),
      wifi.toString(),
      powerBackup.toString(),
      parking.toString(),
      tv.toString(),
      cctv.toString(),
      lift.toString(),
      singleRent.toString(),
      doubleRent.toString(),
      threePlusRent.toString(),
      threePlusRooms.toString(),
      rules.toString(),
      isUploadedToDB.toString(),
    ];
  }
}
