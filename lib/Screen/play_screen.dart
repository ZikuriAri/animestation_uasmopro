import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:animestation_project_uas/Widget/upcoming_widget.dart';

class PlayScreen extends StatefulWidget {
  final String videoUrl;
  final int episodeNumber;
  final String animeId; // Parameter untuk menyimpan riwayat tontonan

  const PlayScreen({
    Key? key,
    required this.videoUrl,
    required this.episodeNumber,
    required this.animeId,
  }) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Inisialisasi VideoPlayerController dengan URL video
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });

    // Panggil fungsi untuk menyimpan riwayat tontonan
    saveWatchHistory(widget.animeId, widget.episodeNumber);
  }

  /// Fungsi untuk menyimpan data riwayat tontonan ke Supabase
  Future<void> saveWatchHistory(String animeId, int episodeNumber) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      print("User belum login");
      return;
    }

    try {
      await supabase.from('watch_history').upsert({
        'user_id': user.id,
        'anime_id': animeId,
        'episode_number': episodeNumber,
        'watched_at': DateTime.now().toIso8601String(),
      });
      print("Riwayat berhasil disimpan");
    } catch (error) {
      print("Gagal menyimpan riwayat: $error");
    }
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Tonton Episode ${widget.episodeNumber} dengan kualitas tinggi!",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 20),
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
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          const UpcomingWidget(),
      
          // Tambahkan widget rekomendasi lainnya jika diperlukan.
        ],
      ),
    );
  }
}