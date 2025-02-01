import 'package:flutter/material.dart';

class Populers extends StatelessWidget {
  const Populers({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
    'TOP POPULERS THIS WEEK',
    style: TextStyle(
      fontSize: 24, // Ukuran font lebih besar
      fontWeight: FontWeight.bold, // Menebalkan font
      letterSpacing: 2.0, // Jarak antar huruf
      color: Color.fromARGB(255, 0, 0, 0), // Warna teks putih
      ),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: 5, // Jumlah item dalam ListView
          itemBuilder: (context, index) {
            // Ganti gambar dan teks sesuai dengan index
            String imagePath = 'assets/images/Demon.jpg'; // Default image path
            String text = 'Item ${index + 1}'; // Teks untuk setiap item

            // Menyesuaikan gambar dan teks untuk setiap item
            if (index == 0) {
              imagePath = 'assets/images/Demon.jpg'; // Gambar untuk item pertama
              text = 'Demon Slayer';
            } else if (index == 1) {
              imagePath = 'assets/images/aot.jpg'; // Gambar untuk item kedua
              text = 'Attack On Titan';
            } else if (index == 2) {
              imagePath = 'assets/images/jujutsu.jpg'; // Gambar untuk item ketiga
              text = 'Jujutsu Kaisen';
            } else if (index == 3) {
              imagePath = 'assets/images/naruto.jpg'; // Gambar untuk item keempat
              text = 'Naruto Shippuden';
            } else if (index == 4) {
              imagePath = 'assets/images/dragon.jpg'; // Gambar untuk item kelima
              text = 'Dragon Ball';
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 20), // Memberikan jarak antar item
              decoration: BoxDecoration(
                color: Colors.teal[200], // Background color
                borderRadius: BorderRadius.circular(15), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    spreadRadius: 2, // Spread of shadow
                    blurRadius: 10, // Blur effect for shadow
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath, // Gambar sesuai dengan index
                      fit: BoxFit.cover, // Gambar memenuhi container
                      height: 200, // Tentukan tinggi gambar
                      width: double.infinity, // Gambar memenuhi lebar container
                    ),
                  ),
                  Positioned(
                    left: 10, // Menempatkan teks di kiri bawah
                    bottom: 10, // Menempatkan teks di bawah
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        text, // Teks untuk setiap item
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Warna teks putih
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(1.0), // Warna shadow
                              offset: Offset(2, 2), // Posisi shadow
                              blurRadius: 3, // Jarak blur shadow
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
