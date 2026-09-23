import 'package:flutter/material.dart';

import 'models/post_model.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal Berita (Infinite Scroll)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const NewsFeedScreen(),
    );
  }
}

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();

  final List<PostModel> _posts = [];

  // State variables
  int _page = 1;
  final int _limit = 10;
  bool _isFirstLoading = true;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchInitialPosts();

    // Listener untuk mendeteksi scroll mahasiswa sampai ke bawah (Infinite Scroll)
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoadingMore &&
          _hasMoreData &&
          _errorMessage == null) {
        _fetchNextPosts();
      }
    });
  }

  // Load pertama kali saat halaman dibuka
  Future<void> _fetchInitialPosts() async {
    setState(() {
      _isFirstLoading = true;
      _errorMessage = null;
      _page = 1;
      _posts.clear();
    });

    try {
      final newPosts = await _apiService.fetchPosts(page: _page, limit: _limit);
      setState(() {
        _posts.addAll(newPosts);
        _isFirstLoading = false;
        if (newPosts.length < _limit) _hasMoreData = false;
      });
    } catch (e) {
      setState(() {
        _isFirstLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  // Load halaman berikutnya saat di-scroll ke bawah
  Future<void> _fetchNextPosts() async {
    setState(() {
      _isLoadingMore = true;
    });

    try {
      _page++;
      final newPosts = await _apiService.fetchPosts(page: _page, limit: _limit);
      setState(() {
        if (newPosts.isEmpty) {
          _hasMoreData = false;
        } else {
          _posts.addAll(newPosts);
        }
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
      // Tampilkan snackbar jika gagal memuat halaman berikutnya
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat berita tambahan: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Berita Terkini'),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // 1. Loading State (Awal)
    if (_isFirstLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Memuat berita...'),
          ],
        ),
      );
    }

    // 2. Error State
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 64,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _fetchInitialPosts,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. Empty State
    if (_posts.isEmpty) {
      return const Center(child: Text('Belum ada berita tersedia.'));
    }

    // 4. Success State (List + Infinite Scroll)
    return RefreshIndicator(
      onRefresh: _fetchInitialPosts, // Fitur Pull to Refresh
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(12),
        itemCount: _posts.length + (_hasMoreData ? 1 : 0),
        itemBuilder: (context, index) {
          // Indikator loading kecil di paling bawah ListView saat fetch page baru
          if (index == _posts.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final post = _posts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${post.id} ${post.title}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.body,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
