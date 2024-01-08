import '../database.dart';

class PgHostelRentTable extends SupabaseTable<PgHostelRentRow> {
  @override
  String get tableName => 'pg_hostel_rent';

  @override
  PgHostelRentRow createRow(Map<String, dynamic> data) => PgHostelRentRow(data);
}

class PgHostelRentRow extends SupabaseDataRow {
  PgHostelRentRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PgHostelRentTable();

  int get id => getField<int>('id')!;

  set id(int value) => setField<int>('id', value);

  double get single => getField<double>('single')!;

  set single(double value) => setField<double>('single', value);

  double get two => getField<double>('two')!;

  set two(double value) => setField<double>('two', value);

  double get threePlus => getField<double>('three_plus')!;

  set threePlus(double value) => setField<double>('three_plus', value);

  int get threePlusRooms => getField<int>('three_plus_rooms')!;

  set threePlusRooms(int value) => setField<int>('three_plus_rooms', value);
}
