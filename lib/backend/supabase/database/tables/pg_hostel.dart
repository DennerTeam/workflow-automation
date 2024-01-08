import '../database.dart';

class PgHostelTable extends SupabaseTable<PgHostelRow> {
  @override
  String get tableName => 'pg_hostel';

  @override
  PgHostelRow createRow(Map<String, dynamic> data) => PgHostelRow(data);
}

class PgHostelRow extends SupabaseDataRow {
  PgHostelRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PgHostelTable();

  int get id => getField<int>('id')!;

  set id(int value) => setField<int>('id', value);

  String get name => getField<String>('name')!;

  set name(String value) => setField<String>('name', value);

  String get location => getField<String>('location')!;

  set location(String value) => setField<String>('location', value);

  String get gender => getField<String>('gender')!;

  set gender(String value) => setField<String>('gender', value);

  String get suitableFor => getField<String>('suited_for')!;

  set suitableFor(String value) => setField<String>('suited_for', value);

  int get rent => getField<int>('rent')!;

  set rent(int value) => setField<int>('rent', value);

  int get amenities => getField<int>('amenities')!;

  set amenities(int value) => setField<int>('amenities', value);

  dynamic get rules => getField<dynamic>('rules')!;

  set rules(dynamic value) => setField<dynamic>('rules', value);

  String get description => getField<String>('description')!;

  set description(String value) => setField<String>('description', value);

  dynamic get photos => getField<dynamic>('photos')!;

  set photos(dynamic value) => setField<dynamic>('photos', value);

  String get contact => getField<String>('contact')!;

  set contact(String value) => setField<String>('contact', value);

  String get email => getField<String>('email')!;

  set email(String value) => setField<String>('email', value);

  double get single => getField<double>('single')!;

  set single(double value) => setField<double>('single', value);

  double get two => getField<double>('two')!;

  set two(double value) => setField<double>('two', value);

  double get threePlus => getField<double>('three_plus')!;

  set threePlus(double value) => setField<double>('three_plus', value);

  int get threePlusRooms => getField<int>('three_plus_rooms')!;

  set threePlusRooms(int value) => setField<int>('three_plus_rooms', value);

  bool get laundry => getField<bool>('laundry')!;

  set laundry(bool value) => setField<bool>('laundry', value);

  bool get mess => getField<bool>('mess')!;

  set mess(bool value) => setField<bool>('mess', value);

  bool get cleaning => getField<bool>('cleaning')!;

  set cleaning(bool value) => setField<bool>('cleaning', value);

  bool get waterSupply => getField<bool>('water_supply')!;

  set waterSupply(bool value) => setField<bool>('water_supply', value);

  bool get fridge => getField<bool>('fridge')!;

  set fridge(bool value) => setField<bool>('fridge', value);

  bool get gym => getField<bool>('gym')!;

  set gym(bool value) => setField<bool>('gym', value);

  bool get geyser => getField<bool>('geyser')!;

  set geyser(bool value) => setField<bool>('geyser', value);

  bool get gatedCommunity => getField<bool>('gated_community')!;

  set gatedCommunity(bool value) => setField<bool>('gated_community', value);

  bool get waterPurifier => getField<bool>('water_purifier')!;

  set waterPurifier(bool value) => setField<bool>('water_purifier', value);

  bool get wifi => getField<bool>('wifi')!;

  set wifi(bool value) => setField<bool>('wifi', value);

  bool get powerBackup => getField<bool>('power_backup')!;

  set powerBackup(bool value) => setField<bool>('power_backup', value);

  bool get parking => getField<bool>('parking')!;

  set parking(bool value) => setField<bool>('parking', value);

  bool get tv => getField<bool>('tv')!;

  set tv(bool value) => setField<bool>('tv', value);

  bool get cctv => getField<bool>('cctv')!;

  set cctv(bool value) => setField<bool>('cctv', value);

  bool get lift => getField<bool>('lift')!;

  set lift(bool value) => setField<bool>('lift', value);

  String get pgHostelLocation => getField<String>('pg_hostel_location')!;

  set pgHostelLocation(String value) =>
      setField<String>('pg_hostel_location', value);

  bool get isAnonymous => getField<bool>('isAnonymous') ?? false;

  set isAnonymous(bool value) => setField<bool>('isAnonymous', value);
}
