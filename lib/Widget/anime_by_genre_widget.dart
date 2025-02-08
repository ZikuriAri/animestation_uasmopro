import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:animestation_project_uas/Widget/detail_anime_widget.dart';

class AnimeByGenreWidget extends StatefulWidget {
  final String genre;

  const AnimeByGenreWidget({Key? key, required this.genre}) : super(key: key);

  @override
  _AnimeByGenreWidgetState createState() => _AnimeByGenreWidgetState();
}

class _AnimeByGenreWidgetState extends State<AnimeByGenreWidget> {
  final supabase = Supabase.instance.client;
  List<dynamic> animeList = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchAnime();
  }

  // Jika widget menerima genre baru, ambil data ulang.
  @override
  void didUpdateWidget(covariant AnimeByGenreWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.genre != widget.genre) {
      fetchAnime();
    }
  }

  Future<void> fetchAnime() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      // Menggunakan operator 'cs' untuk memeriksa apakah kolom array 'genre'
      // mengandung genre yang dipilih.
      final response = await supabase
          .from('animes')
          .select()
          .filter('genre', 'cs', [widget.genre]);

      setState(() {
        animeList = response as List<dynamic>;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching anime: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }
    if (animeList.isEmpty) {
      return const Center(child: Text("No anime found for this genre."));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: animeList.length,
      itemBuilder: (context, index) {
        final anime = animeList[index];
        return GestureDetector(
          onTap: () {
            // Navigasi ke halaman detail anime
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailAnimeWidget(
                  animeId: anime["id"].toString(),
                  title: anime["title"] ?? "No Title",
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
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Anime
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    anime["image_url"] ?? "https://via.placeholder.com/150",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                // Judul Anime
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    anime["title"] ?? "No Title",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}