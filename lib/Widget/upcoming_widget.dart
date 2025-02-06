import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
          .select('title, image_url')
          .limit(5);

      if (response.isEmpty) {
        setState(() {
          isLoading = false;
          errorMessage = "Tidak ada rekomendasi anime.";
        });
      } else {
        setState(() {
          recommendations = response;
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = "Gagal mengambil data: $error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Rekomendasi",
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
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: recommendations.map((anime) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            anime["image_url"] ?? "",
                            height: 150,
                            width: 300,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 100),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
    ]);
  }
}
