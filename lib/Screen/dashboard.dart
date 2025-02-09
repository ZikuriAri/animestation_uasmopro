import 'package:flutter/material.dart';
import 'package:animestation_project_uas/Widget/new_anime_widget.dart';
import 'package:animestation_project_uas/Widget/upcoming_widget.dart';
import 'package:animestation_project_uas/Screen/search_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final supabase = Supabase.instance.client;
  String userEmail = "Guest";
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    fetchUserEmail(); // Panggil fungsi yang benar
  }

  Future<void> fetchUserEmail() async {
    final user = supabase.auth.currentUser;

    if (user != null) {
      setState(() {
        userEmail = user.email ?? "No Email Found";
        isLoading = false;
      });
    } else {
      setState(() {
        userEmail = "Guest";
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEFF6), // Background soft pink
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Menampilkan sapaan dengan nama pengguna
                Row(
                    children: [
                      // Avatar Profil di sebelah kiri
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          "assets/images/ns3.jpg",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12), // Jarak antara gambar dan teks

                      // Kolom untuk teks
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isLoading
                              ? const Text(
                                  "Loading...",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Hello,", // ✅ "Hello," di atas
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      userEmail, // ✅ Email atau Username di bawahnya
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 4), // Jarak agar lebih rapi
                          const Text(
                            "What to Watch?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                const SizedBox(height: 20),
                // Search Bar
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onSubmitted: (query) {
                      // Jika query tidak kosong, navigasi ke SearchScreen
                      if (query.trim().isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchScreen(query: query.trim()),
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.black),
                      hintText: "Search",
                      border: InputBorder.none,
                      hintStyle: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Judul untuk bagian rekomendasi
                const Text(
                  "Rekomendasi Untukmu",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Widget untuk menampilkan rekomendasi anime
                const UpcomingWidget(),
                const SizedBox(height: 20),
                // Judul untuk bagian rilisan terbaru
                const Text(
                  "Rilisan Terbaru",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Widget untuk menampilkan anime terbaru
                const NewAnimeWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
