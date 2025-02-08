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

  /// Mengambil data watch history berdasarkan user yang sedang login
  Future<void> fetchWatchHistory() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        setState(() {
          errorMessage = 'User belum login.';
          isLoading = false;
        });
        return;
      }
      final response = await supabase
          .from('watch_history')
          .select()
          .eq('user_id', user.id);
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

  /// Menghapus satu item history dari database dan state lokal
  Future<void> deleteHistoryItem(String historyId, int index) async {
    try {
      final response = await supabase
          .from('watch_history')
          .delete()
          .eq('id', historyId);
      if (response.error == null) {
        setState(() {
          watchHistory.removeAt(index);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus: ${response.error!.message}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi error: $error')),
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
                        "No history available",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: watchHistory.length,
                      itemBuilder: (context, index) {
                        final historyItem = watchHistory[index];
                        // Asumsikan tabel watch_history memiliki kolom:
                        // id, title, genre, image, watched_at
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                historyItem["image"] ?? "https://via.placeholder.com/150",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              historyItem["title"] ?? "No Title",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "${historyItem["genre"]} • Watched on ${historyItem["watched_at"] != null ? historyItem["watched_at"].toString().substring(0, 10) : ''}",
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