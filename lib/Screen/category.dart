import 'package:flutter/material.dart';
import 'package:animestation_project_uas/Screen/setting.dart';
import 'package:animestation_project_uas/Screen/search_screen.dart';
import 'package:animestation_project_uas/Widget/anime_by_genre_widget.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // Menyimpan genre yang dipilih (null jika belum ada)
  String? selectedGenre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Setting()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onSubmitted: (query) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen(query: query)),
                );
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            // Kategori Genre (dengan tombol)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ["Action", "Comedy", "Drama", "Horror", "Shonen"]
                  .map(
                    (genre) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedGenre == genre ? Colors.blueAccent : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedGenre = genre;
                        });
                      },
                      child: Text(genre),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            // Jika genre sudah dipilih, tampilkan widget yang menampilkan anime berdasarkan genre
            Expanded(
              child: selectedGenre != null
                  ? AnimeByGenreWidget(genre: selectedGenre!)
                  : const Center(
                      child: Text("Select a genre to see anime."),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}