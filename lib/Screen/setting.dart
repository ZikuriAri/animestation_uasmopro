import 'package:flutter/material.dart';

//nyoba push di setting lewat branch lain
class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 24, // Ukuran font lebih besar
            fontWeight: FontWeight.bold, // Menebalkan font
            letterSpacing: 2.0, // Jarak antar huruf
            color: Color.fromARGB(255, 0, 0, 0), // Warna teks putih
          ),
        ),
      ),
      body: ListView(
        children: [
          // Profile section
          // Change Password section
          ListTile(
            title: const Text("Change Password"),
            leading: const Icon(Icons.lock),
            onTap: () {
              // Aksi saat item ini dipilih
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Change Password"),
                    content: const Text("You can change your password here."),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          // Privacy Settings section
          ListTile(
            title: const Text("Privacy Settings"),
            leading: const Icon(Icons.privacy_tip),
            onTap: () {
              // Aksi saat item ini dipilih
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Privacy Settings"),
                    content: const Text("You can adjust your privacy settings here."),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          // Hapus Akun section
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 60), // Ukuran besar tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Sudut tombol yang melengkung
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Hapus Akun"),
                      content: const Text("Apakah Anda yakin ingin menghapus akun?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Menutup dialog
                          },
                          child: const Text("Batal"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Aksi hapus akun
                            Navigator.pop(context);
                          },
                          child: const Text("Hapus Akun"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(
                "Hapus Akun",
                style: TextStyle(fontSize: 18), // Ukuran teks pada tombol
              ),
            ),
          ),
        ],
      ),
    );
  }
}
