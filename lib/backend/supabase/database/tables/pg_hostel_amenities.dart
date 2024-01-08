import '../database.dart';

class PgHostelAmenitiesTable extends SupabaseTable<PgHostelAmenitiesRow> {
  @override
  String get tableName => 'pg_hostel_amenities';

  @override
  PgHostelAmenitiesRow createRow(Map<String, dynamic> data) =>
      PgHostelAmenitiesRow(data);
}

class PgHostelAmenitiesRow extends SupabaseDataRow {
  PgHostelAmenitiesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PgHostelAmenitiesTable();

  int get id => getField<int>('id')!;

  set id(int value) => setField<int>('id', value);

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
}
