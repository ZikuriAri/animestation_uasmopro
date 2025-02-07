import 'package:flutter/material.dart';
import 'package:animestation_project_uas/Screen/play_screen.dart';

class DetailAnimeWidget extends StatelessWidget {
  final String title;
  final String genre;
  final String imageUrl;
  final String description;
  final String releaseYear;

  const DetailAnimeWidget({
    super.key,
    required this.title,
    required this.genre,
    required this.imageUrl,
    required this.description,
    required this.releaseYear,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Gambar background atas
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 100),
          ),

          // Tombol Kembali
          Positioned(
            top: 40, // Posisi agar tidak tertutup status bar
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
              ),
            ),
          ),

          // Konten Utama
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 200),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Informasi Anime
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              imageUrl,
                              width: 120,
                              height: 160,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 100),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                genre,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                releaseYear,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Deskripsi Anime
                      const Text(
                        "Synopsis:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),

                      const SizedBox(height: 20),

                      // Tombol Play & Info
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Aksi saat tombol play ditekan
                            },
                            child: Container(
                              width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Icon(Icons.play_arrow, color: Colors.white, size: 30),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: const Center(
                              child: Icon(Icons.info_outline, color: Colors.blueAccent, size: 30),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Judul Episode
                      const Text(
                        "Episodes",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      // Daftar Episode dalam Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemCount: 25, // Jumlah episode
                        itemBuilder: (context, index) {
                          int episodeNumber = index + 1; // Nomor episode

                          return GestureDetector(
                            onTap: () {
                              // Navigasi ke PlayScreen dengan episode yang dipilih
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayScreen(
                                    videoUrl:
                                        "https://biuecnhtyxbkmdtetuio.supabase.co/storage/v1/object/public/video/episode_$episodeNumber.mp4",
                                    episodeNumber: episodeNumber,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "$episodeNumber",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
}