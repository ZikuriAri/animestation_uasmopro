import 'package:flutter/material.dart';
import 'package:animestation_project_uas/Widget/new_anime_widget.dart';
import 'package:animestation_project_uas/Widget/upcoming_widget.dart';
import 'package:animestation_project_uas/Screen/search_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Misalnya, Anda sudah punya nama user dari proses login.
  // Jika belum, Anda bisa mengambilnya secara asinkronus seperti yang sebelumnya.
  String userName = "Your Name";
  bool isLoadingName = false;

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Teks sapaan dengan nama pengguna (atau "Loading..." jika data belum siap)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoadingName
                            ? const Text(
                                "Loading...",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            : Text(
                                "Hello $userName",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                        const Text(
                          "What to Watch?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    // Avatar Profil (pastikan asset gambar tersedia)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        "assets/images/koboo.jpg",
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
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
                UpcomingWidget(),
                const SizedBox(height: 20),
                // Judul untuk bagian rilisan terbaru
                const Text(
                  "Rilisan Terbaru",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Widget untuk menampilkan anime terbaru
                NewAnimeWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}