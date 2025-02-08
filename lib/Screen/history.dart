import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WatchHistoryScreen extends StatefulWidget {
  const WatchHistoryScreen({Key? key}) : super(key: key);

  @override
  _WatchHistoryScreenState createState() => _WatchHistoryScreenState();
}

class _WatchHistoryScreenState extends State<WatchHistoryScreen> {
  final supabase = Supabase.instance.client;
  List<dynamic> watchHistory = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchWatchHistory();
  }

  /// Ambil data history berdasarkan user yang sedang login dan
  /// sertakan data judul serta gambar anime dari relasi tabel `animes`.
  Future<void> fetchWatchHistory() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      setState(() {
        errorMessage = 'User belum login.';
        isLoading = false;
      });
      return;
    }
    try {
      final response = await supabase
          .from('watch_history')
          .select('id, anime_id, episode_number, watched_at, animes(title, image_url)')
          .eq('user_id', user.id)
          .order('watched_at', ascending: false);

      setState(() {
        watchHistory = response as List<dynamic>;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error mengambil data history: $error';
        isLoading = false;
      });
    }
  }

  /// Fungsi untuk menghapus satu item history
  Future<void> deleteHistoryItem(String historyId, int index) async {
    try {
      await supabase.from('watch_history').delete().eq('id', historyId);
      setState(() {
        watchHistory.removeAt(index);
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watch History"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : watchHistory.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada riwayat tontonan",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: watchHistory.length,
                      itemBuilder: (context, index) {
                        final historyItem = watchHistory[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                historyItem['animes']['image_url'] ??
                                    "https://via.placeholder.com/150",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              historyItem['animes']['title'] ?? "No Title",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Episode ${historyItem["episode_number"]} • Ditonton pada ${historyItem["watched_at"].substring(0, 10)}",
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteHistoryItem(historyItem["id"].toString(), index),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}