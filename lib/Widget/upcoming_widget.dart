import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:animestation_project_uas/Widget/detail_anime_widget.dart';

class UpcomingWidget extends StatefulWidget {
  const UpcomingWidget({super.key});

  @override
  _UpcomingWidgetState createState() => _UpcomingWidgetState();
}

class _UpcomingWidgetState extends State<UpcomingWidget> {
  final supabase = Supabase.instance.client;
  List<dynamic> recommendations = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchRecommendations();
  }

  Future<void> fetchRecommendations() async {
    try {
      final response = await supabase
          .from('animes')
          .select('id, title, genre, image_url, description, release_year')
          .limit(5);
      setState(() {
        recommendations = response as List<dynamic>;
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
        ? const CircularProgressIndicator()
        : errorMessage.isNotEmpty
            ? Text(errorMessage)
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: recommendations.map((anime) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailAnimeWidget(
                              animeId: anime["id"],
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            anime["image_url"] ?? "https://via.placeholder.com/150",
                            height: 150,
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
  }
}