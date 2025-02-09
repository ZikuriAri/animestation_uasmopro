import 'package:animestation_project_uas/Screen/login_screen.dart';
import 'package:animestation_project_uas/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:animestation_project_uas/Auth/login.dart';
import 'package:animestation_project_uas/Screen/setting.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  final supabase = Supabase.instance.client;
  String userEmail = "Guest";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserEmail();
  }

  Future<void> fetchUserEmail() async {
    final user = supabase.auth.currentUser;

    setState(() {
      if (user != null) {
        userEmail = user.email ?? "No Email Found";
      } else {
        userEmail = "Guest";
      }
      isLoading = false;
    });
  }

  Future<void> logoutUser() async {
  await supabase.auth.signOut(); // 🔴 Logout dari Supabase
  if (mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const login()), // 🔄 Kembali ke halaman Login
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/kobo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 200),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage('assets/images/koboo.jpg'),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        isLoading ? "Loading..." : userEmail, // ✅ Perbaikan
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.black),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Anime Lover | Movie Enthusiast',
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem('1200', 'Followers'),
                          _buildStatItem('350', 'Watching'),
                          _buildStatItem('50', 'Favorites'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Favorite Shows',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildFavoriteItem('Demon Slayer', 'assets/images/Demon.jpg'),
                            _buildFavoriteItem('Attack on Titan', 'assets/images/eren.png'),
                            _buildFavoriteItem('Jujutsu Kaisen', 'assets/images/jujutsu.jpg'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Preferences',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Column(
                      children: [
                        _buildPreferenceItem(Icons.notifications, 'Pengingat'),
                        _buildPreferenceItem(Icons.download, 'Unduh'),
                        _buildPreferenceItem(Icons.settings, 'Pengaturan'),
                        _buildPreferenceItem(Icons.exit_to_app, 'Logout', isLogout: true), // ✅ Tambahkan logout
                      ],
                    ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildFavoriteItem(String title, String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imagePath, width: 120, height: 100, fit: BoxFit.cover),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem(IconData icon, String title, {bool isLogout = false}) {
  return ListTile(
    leading: Icon(icon, color: isLogout ? Colors.red : Colors.black), // 🔴 Ikon merah untuk Logout
    title: Text(
      title,
      style: TextStyle(fontSize: 16, color: isLogout ? Colors.red : Colors.black), // 🔴 Teks merah untuk Logout
    ),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    onTap: isLogout ? logoutUser : () {}, // 🔴 Logout jika tombol Logout ditekan
  );
}
}
