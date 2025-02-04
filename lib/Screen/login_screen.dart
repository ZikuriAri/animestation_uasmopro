import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  // supabase setup
  await Supabase.initialize(
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJpdWVjbmh0eXhia21kdGV0dWlvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg1OTkwODAsImV4cCI6MjA1NDE3NTA4MH0.-6m89p8iO0BmdtY7ZeqWzIuQg9oAdYca3uSznWMXSWQ',
    url: 'https://biuecnhtyxbkmdtetuio.supabase.co');
 
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