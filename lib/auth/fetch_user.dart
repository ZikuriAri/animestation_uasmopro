import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FetchUser extends StatefulWidget {
  const FetchUser({super.key});

  @override
  State<FetchUser> createState() => _FetchUserState();
}

class _FetchUserState extends State<FetchUser> {
  final supabase = Supabase.instance.client;
  String userName = "Guest"; // Default jika tidak ada user yang login
  bool isLoading = true; // Indikator loading

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        final response = await supabase
            .from('users') // Pastikan tabel 'users' ada di Supabase
            .select('username')
            .eq('id', user.id)
            .single(); // Ambil satu data saja

        setState(() {
          userName = response['username'] ?? "Guest"; // Jika username kosong, tampilkan "Guest"
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          userName = "Guest"; // Jika gagal mengambil data, gunakan default
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fetch User")),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                "Hello, $userName!",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
