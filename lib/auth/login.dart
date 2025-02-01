import 'package:flutter/material.dart';
import 'package:animestation_project_uas/nav_bar.dart';
import 'package:animestation_project_uas/Scaffold/custom_scaffold.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
  
}

class _LoginScreenState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Container(
        width: 400,
        height: 480,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(237, 255, 255, 255),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Image.asset(
                  'assets/images/zikuriari.png', // Ganti dengan path gambar Anda
                  height: 80,),
               const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0), // Menambahkan margin atas dan bawah
                  child: Text(
                    'Welcome to Your Account',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 60, 61, 65),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                   if (_formKey.currentState!.validate()) {
                    // Jika form valid, lakukan proses login
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    // Navigasi ke halaman MenuScreen dengan mengoper email
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBar(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(237, 255, 255, 255), // Mengubah warna latar belakang menjadi ungu
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 15,
                  color: Color.fromARGB(255, 102, 9, 97),
                  
                  ),
                ),
              ),
            Padding(
            padding: const EdgeInsets.all(5.0), // Margin di sekitar seluruh Column
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Tambahkan logika login dengan Google di sini
                  },
                  icon: Image.asset(
                    'assets/images/google.png', // Path logo Google Anda
                    height: 15,
                    width: 15,
                  ),
                  label: const Text(
                    'Login with Google',
                    style: TextStyle(fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.grey), // Border tipis untuk tombol
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 2,
                  ),
                ),
                 ElevatedButton.icon(
                  onPressed: () {
                    // Tambahkan logika login dengan Google di sini
                  },
                  icon: Image.asset(
                    'assets/images/fb.png', // Path logo Google Anda
                    height: 15,
                    width: 15,
                  ),
                  label: const Text(
                    'Login with Facebook',
                    style: TextStyle(fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.grey), // Border tipis untuk tombol
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 2,
                  ),
                ),
              ],
            ),
          )


            ],
          ),
        ),
      ),
    );
  }
}