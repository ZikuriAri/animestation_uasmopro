import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:animestation_project_uas/Widget/detail_anime_widget.dart';

class NewAnimeWidget extends StatefulWidget {
  const NewAnimeWidget({super.key});

  @override
  _NewAnimeWidgetState createState() => _NewAnimeWidgetState();
}

class _NewAnimeWidgetState extends State<NewAnimeWidget> {
  final supabase = Supabase.instance.client;
  List<dynamic> animeList = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchAnime();
  }

  Future<void> fetchAnime() async {
    try {
      // Hapus .execute() karena tidak digunakan di supabase_flutter v2.8.3
      final response = await supabase
          .from('animes')
          .select('id, title, genre, rating, image_url, description, release_year');
      setState(() {
        animeList = response as List<dynamic>;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = "Gagal mengambil data: $error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: animeList.length,
                itemBuilder: (context, index) {
                  final anime = animeList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailAnimeWidget(
                            // Kirim animeId agar DetailAnimeWidget dapat mengambil data episode
                            animeId: anime["id"],
                            title: anime["title"] ?? "No Title",
                            // Jika genre berupa List, pastikan dikonversi dengan benar
                            genre: anime["genre"] is List
                                ? (anime["genre"] as List<dynamic>).join(', ')
                                : anime["genre"] ?? "Unknown Genre",
                            imageUrl: anime["image_url"] ?? "https://via.placeholder.com/150",
                            description: anime["description"] ?? "No description available.",
                            releaseYear: anime["release_year"]?.toString() ?? "Unknown Year",
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            anime["image_url"] ?? "https://via.placeholder.com/150",
                            height: 170,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 100),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          anime["title"] ?? "No Title",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          anime["genre"] is List
                              ? (anime["genre"] as List<dynamic>).join(', ')
                              : anime["genre"] ?? "Unknown Genre",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.stars, color: Colors.amber),
                            const SizedBox(width: 5),
                            Text(
                              anime["rating"]?.toString() ?? "N/A",
                              style: const TextStyle(color: Colors.black, fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
  }
}