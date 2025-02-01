import 'package:flutter/material.dart';

class NewAnimeWidget extends StatelessWidget {
  const NewAnimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar data anime
    final List<Map<String, String>> animeData = [
      {
        "title": "Blue lock",
        "genre": "Action/Sports",
        "rating": "8.5",
        "image": "assets/images/ns1.jpg"
      },
      {
        "title": "Dan Dan Dan",
        "genre": "Fantasy/Action",
        "rating": "8.9",
        "image": "assets/images/ns2.jpg"
      },
      {
        "title": "Solo Leveling",
        "genre": "Supernatural/Fantasy",
        "rating": "8.7",
        "image": "assets/images/ns3.jpg"
      },
      {
        "title": "Blue Box",
        "genre": "Romance/Sport",
        "rating": "8.3",
        "image": "assets/images/ao.jpg"
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "New Animes",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  color: Color.fromARGB(255, 102, 102, 102),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: animeData.length,
          itemBuilder: (context, index) {
            final anime = animeData[index];
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
                      child: Image.asset(
                        anime["image"]!,
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            anime["title"]!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            anime["genre"]!,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                anime["rating"]!,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
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
        )
      ],
    );
  }
}
