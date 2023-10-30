import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://hwmbhsmwgtzsccdccadb.supabase.co';
const supabaseApiKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh3bWJoc213Z3R6c2NjZGNjYWRiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyOTkwMTAsImV4cCI6MjAxMzg3NTAxMH0.U9cIWHqUZxTZ1w1Vt1j6orS8FPKuQHknRjbiVE5JkN8'; // Replace with your API key

final supabaseclient = SupabaseClient(supabaseUrl, supabaseApiKey);
