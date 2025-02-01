import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  // supabase setup
  await Supabase.initialize(
    url: 'https://lwglbuxaycyeiwgfjgqa.supabase.co', 
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx3Z2xidXhheWN5ZWl3Z2ZqZ3FhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0NzY4MDcsImV4cCI6MjA1MzA1MjgwN30.C2F8eCd5j2ucrCDZ1xBU2ik1NE6_cPLwJeJ0PUSJVWQ');
 
  runApp(const login());
}

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(),
    );
  }
}