import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:animestation_project_uas/Screen/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan Flutter binding sudah siap

  await Supabase.initialize(
    url: 'https://biuecnhtyxbkmdtetuio.supabase.co',  // Ganti dengan URL Supabase-mu
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJpdWVjbmh0eXhia21kdGV0dWlvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg1OTkwODAsImV4cCI6MjA1NDE3NTA4MH0.-6m89p8iO0BmdtY7ZeqWzIuQg9oAdYca3uSznWMXSWQ',  // Ganti dengan Anon Key dari Supabase
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animestation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
