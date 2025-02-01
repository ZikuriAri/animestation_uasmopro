import 'package:flutter/material.dart';

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
          ListTile(
            title: const Text("Edit Profile"),
            leading: const Icon(Icons.edit),
            onTap: () {
              // Aksi saat item ini dipilih
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Edit Profile"),
                    content: const Text("You can edit your profile here."),
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
          
          // Notifications section
          ListTile(
            title: const Text("Notifications"),
            leading: const Icon(Icons.notifications),
            onTap: () {
              // Aksi saat item ini dipilih
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Notifications Settings"),
                    content: const Text("You can adjust your notification preferences here."),
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
          
          // Logout section
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.logout),
            onTap: () {
              // Aksi saat item ini dipilih
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to log out?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Keluar dari dialog
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Aksi logout
                          Navigator.pop(context);
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}