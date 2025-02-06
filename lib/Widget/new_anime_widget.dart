import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      final response = await supabase
          .from('animes')
          .select('title, genre, rating, image_url')
          .order('created_at', ascending: false)
          .limit(10);

      print("Data dari Supabase: $response"); // Debugging

      setState(() {
        animeList = response;
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
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("New Animes",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500)),
              Text("See All",
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 102, 102), fontSize: 16)),
            ],
          ),
        ),
        const SizedBox(height: 15),
        isLoading
            ? const CircularProgressIndicator()
            : errorMessage.isNotEmpty
                ? Text(errorMessage)
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: animeList.length,
                    itemBuilder: (context, index) {
                      final anime = animeList[index];

                      return InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 243, 243),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  anime["image_url"]?.isNotEmpty == true
                                      ? anime["image_url"]
                                      : "https://via.placeholder.com/150",
                                  height: 170,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(Icons.broken_image,
                                              size: 100),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      anime["title"] ?? "No Title",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 5),
                                    // Updated genre display
                                    Text(
                                      (anime["genre"] is List
                                          ? (anime["genre"] as List<dynamic>)
                                              .join(', ')
                                          : anime["genre"]?.toString()) ??
                                          "Unknown Genre",
                                      style: const TextStyle(
                                          color: Colors.black54, fontSize: 16),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber),
                                        const SizedBox(width: 5),
                                        Text(
                                          anime["rating"]?.toString() ?? "N/A",
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ],
    );
  }
}