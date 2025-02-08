import 'package:flutter/material.dart';
import 'package:animestation_project_uas/Screen/play_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailAnimeWidget extends StatefulWidget {
  final String animeId;
  final String title;
  final String genre;
  final String imageUrl;
  final String description;
  final String releaseYear;

  const DetailAnimeWidget({
    super.key,
    required this.animeId,
    required this.title,
    required this.genre,
    required this.imageUrl,
    required this.description,
    required this.releaseYear,
  });

  @override
  _DetailAnimeWidgetState createState() => _DetailAnimeWidgetState();
}

class _DetailAnimeWidgetState extends State<DetailAnimeWidget> {
  List<dynamic> episodes = [];

  @override
  void initState() {
    super.initState();
    fetchEpisodes();
  }

  Future<void> fetchEpisodes() async {
    try {
      final response = await Supabase.instance.client
          .from('episodes')
          .select()
          .eq('anime_id', widget.animeId)
          .order('episode_number', ascending: true);
      setState(() {
        episodes = response as List<dynamic>;
      });
    } catch (error) {
      print('Error fetching episodes: $error');
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xFFFCEFF6), // Transparan agar menyatu dengan gambar
      elevation: 0, // Hilangkan shadow
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 0, 0, 0)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    body: Stack(
      children: [
        /// 🔹 Background Gambar
        Positioned.fill(
          child: Image.network(
            widget.imageUrl,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),

        /// 🔹 Tombol Back (Pastikan di atas elemen lainnya)

        /// 🔹 Konten Anime
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 200), // Untuk memberi ruang agar gambar terlihat
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
                    Text(widget.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(widget.genre, style: const TextStyle(color: Colors.grey)),
                    Text(widget.releaseYear, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 20),
                    const Text("Synopsis:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(widget.description, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),

                    /// 🔹 Tombol Episode
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: episodes.length,
                      itemBuilder: (context, index) {
                        final episode = episodes[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayScreen(
                                  videoUrl: episode['video_url'],
                                  episodeNumber: episode['episode_number'],
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
                                "${episode['episode_number']}",
                                style: const TextStyle(color: Colors.white, fontSize: 18),
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