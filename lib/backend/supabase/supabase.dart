import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

export 'database/database.dart';

const _kSupabaseUrl = 'https://dffzjlczlmcmtijfuimq.supabase.co';
const _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRmZnpqbGN6bG1jbXRpamZ1aW1xIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODg5MDM4MTIsImV4cCI6MjAwNDQ3OTgxMn0.Ja8cOF1QypzfljwUg5nheBGTiblLLbXWz56JQ_q2VrY';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        anonKey: _kSupabaseAnonKey,
        debug: false,
      );
}
