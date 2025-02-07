import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:animestation_project_uas/Widget/new_anime_widget.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late VideoPlayerController _controller;

   @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://biuecnhtyxbkmdtetuio.supabase.co/storage/v1/object/public/video//videoplayback%20(4).mp4', // Ganti dengan URL video Anda
    )
      ..initialize().then((_) {
        setState(() {});
      });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Selamat Menonton!"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Deskripsi singkat
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Tonton episode favoritmu dengan kualitas tinggi untuk pengalaman menonton yang maksimal!",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 20),

          // Video Player
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const Center(child: CircularProgressIndicator()),

          const SizedBox(height: 20),

          // Tombol Play/Pause
         ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            });
          },
          icon: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white, // Warna ikon putih
          ),
          label: Text(
            _controller.value.isPlaying ? "Pause" : "Play",
            style: TextStyle(color: Colors.white), // Warna teks putih
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Warna tombol
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),

          SizedBox(height: 40),
            NewAnimeWidget(),
        ],
      ),
    );
  }
}
