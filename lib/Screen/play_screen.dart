import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:animestation_project_uas/Widget/new_anime_widget.dart';
import 'package:animestation_project_uas/Widget/upcoming_widget.dart';

class PlayScreen extends StatefulWidget {
  final String videoUrl;
  final int episodeNumber;

  const PlayScreen({
    super.key,
    required this.videoUrl,
    required this.episodeNumber,
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
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
      backgroundColor: const Color(0xFFFCEFF6),
      appBar: AppBar(
        title: Text("Episode ${widget.episodeNumber}"),
        backgroundColor: const Color(0xFFFCEFF6),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Deskripsi singkat
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Tonton Episode ${widget.episodeNumber} dengan kualitas tinggi!",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
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
              color: Colors.white,
            ),
            label: Text(
              _controller.value.isPlaying ? "Pause" : "Play",
              style: const TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Rekomendasi Anime lainnya di bawah ini!",
              style: const TextStyle(
                fontSize: 22, // Sedikit lebih besar agar lebih jelas
                fontWeight: FontWeight.bold, // Membuat teks bold
                color: Colors.black87, // Warna lebih kontras
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10),
                // Widget untuk menampilkan anime terbaru
                UpcomingWidget(),
        ],
      ),
    );
  }
}
