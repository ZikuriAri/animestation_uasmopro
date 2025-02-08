import 'package:animestation_project_uas/Widget/detail_anime_widget.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final supabase = Supabase.instance.client;
  List<dynamic> searchResults = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSearchResults();
  }

  Future<void> fetchSearchResults() async {
    try {
      final response = await supabase
          .from('animes')
          .select('id, title, genre, image_url, description, release_year')
          .ilike('title', '%${widget.query}%');
      setState(() {
        searchResults = response as List<dynamic>;
        isLoading = false;
      });
    } catch (error) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search: ${widget.query}"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : searchResults.isEmpty
              ? const Center(child: Text("No results found"))
              : ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final anime = searchResults[index];
                    return ListTile(
                      leading: Image.network(
                        anime['image_url'] ?? "https://via.placeholder.com/150",
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                      title: Text(anime['title']),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailAnimeWidget(
                            animeId: anime["id"],
                            title: anime['title'],
                            genre: anime['genre'] is List
                                ? (anime['genre'] as List<dynamic>).join(', ')
                                : anime['genre'],
                            imageUrl: anime['image_url'],
                            description: anime['description'],
                            releaseYear: anime['release_year']?.toString() ?? "Unknown Year",
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
