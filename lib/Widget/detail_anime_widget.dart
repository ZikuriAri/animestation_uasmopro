import 'package:animestation_project_uas/Screen/play_screen.dart';
import 'package:flutter/material.dart';

class DetailAnimeWidget extends StatelessWidget {
  const DetailAnimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      body: Stack(
        children: [
          Opacity(
            opacity: 0, // Transparansi latar belakang
            child: Image.asset(
              "assets/images/aot.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250, // Meningkatkan tinggi untuk efek hero image
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)?.withOpacity(1), // Warna lebih gelap dengan efek transparan
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 120,
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/eren.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Attack on Titan",
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                Text(
                                  "Action, Drama, Fantasy",
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                                Text(
                                  "2013 - 2023",
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Eren Yeager dan kawan-kawan bertarung melawan Titan demi kebebasan umat manusia. "
                          "Namun, rahasia di balik tembok mengubah segalanya.",
                          style: TextStyle(fontSize: 16, height: 1.5, color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        const SizedBox(height: 20),
                       Row(
                        children: [
                          // Tombol "Play" lebih panjang di sebelah kiri
                          GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PlayScreen()),
                            );
                          },
                          child: Container(
                            width: 250, // Lebih panjang
                            height: 50, // Tinggi tetap
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Icon(Icons.play_arrow, color: Colors.white, size: 30),
                            ),
                          ),
                        ),

                          const SizedBox(width: 20), // Jarak antar tombol
                          // Tombol "Info" berbentuk 1:1 di sebelah kanan
                          Container(
                            width: 50, // Ukuran 1:1 (persegi)
                            height: 50, 
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Icon(Icons.info_outline, color: Color.fromARGB(255, 0, 0, 0), size: 30),
                            ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10), // Spasi sebelum daftar episode

                            // Judul untuk daftar episode
                            const Text(
                              "Semua Episode",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            const SizedBox(height: 10),

                            // GridView untuk menampilkan nomor episode
                            SizedBox(
                              height: 350, // Membatasi tinggi agar bisa digulir jika banyak
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5, // 5 tombol per baris
                                  crossAxisSpacing: 10, // Jarak antar kolom
                                  mainAxisSpacing: 10, // Jarak antar baris
                                  childAspectRatio: 1, // Ukuran 1:1 (kotak)
                                ),
                                itemCount: 25, // Jumlah episode (bisa disesuaikan)
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Aksi ketika episode diklik
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
