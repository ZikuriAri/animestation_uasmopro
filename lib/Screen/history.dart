import 'package:flutter/material.dart';

class WatchHistoryScreen extends StatefulWidget {
  const WatchHistoryScreen({super.key});

  @override
  _WatchHistoryScreenState createState() => _WatchHistoryScreenState();
}

class _WatchHistoryScreenState extends State<WatchHistoryScreen> {
  // Data dummy untuk riwayat film yang sudah ditonton
  List<Map<String, String>> watchHistory = [
    {
      "title": "Blue lock",
      "genre": "Action/Sports",
      "rating": "8.5",
      "image": "assets/images/ns1.jpg",
      "date": "Jan 20, 2024"
    },
    {
      "title": "Dan Dan Dan",
      "genre": "Fantasy/Action",
      "rating": "8.9",
      "image": "assets/images/ns2.jpg",
      "date": "Feb 10, 2024"
    },
    {
      "title": "Solo Leveling",
      "genre": "Supernatural/Fantasy",
      "rating": "8.7",
      "image": "assets/images/ns3.jpg",
      "date": "Mar 5, 2024"
    },
    {
      "title": "Blue Box",
      "genre": "Romance/Sport",
      "rating": "8.3",
      "image": "assets/images/ao.jpg",
      "date": "Apr 15, 2024"
    },
  ];

  // Fungsi untuk menghapus item dari riwayat
  void _deleteHistory(int index) {
    setState(() {
      watchHistory.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "History",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.black),
                  onPressed: () {
                    debugPrint('Settings pressed');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: watchHistory.isEmpty
                ? const Center(
                    child: Text(
                      "No history available",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: watchHistory.length,
                    itemBuilder: (context, index) {
                      final anime = watchHistory[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              anime["image"]!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            anime["title"]!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              "${anime["genre"]} • Watched on ${anime["date"]}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteHistory(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
