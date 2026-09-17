import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const DemoAsyncApp());
}

class DemoAsyncApp extends StatelessWidget {
  const DemoAsyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Sync vs Async',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  String _statusSync = "Belum dijalankan";
  String _statusAsync = "Belum dijalankan";
  bool _isLoadingAsync = false;

  Key _streamKey = UniqueKey();
  void _runSyncProcess() {
    setState(() {
      _statusSync = "Proses Sync dimulai...";
    });

    sleep(const Duration(seconds: 3));

    setState(() {
      _statusSync = "Selesai! (Terjadi lag/freeze 3 detik pada UI)";
    });
  }

  Future<void> _runAsyncProcess() async {
    setState(() {
      _isLoadingAsync = true;
      _statusAsync = "Proses Async dimulai...";
    });

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isLoadingAsync = false;
      _statusAsync = "Selesai! (UI tetap responsif dan lancar)";
    });
  }

  Stream<int> _generateStreamData() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo: Sync vs Async Flutter'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.amber.shade100,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'INDIKATOR RESPONSIVITAS UI',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Perhatikan animasi spinner di bawah. Jika spinner mendadak MACET/DIAM, artinya UI terblokir!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 12),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. Tanpa Async (Synchronous / Blocking)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Status: $_statusSync'),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _runSyncProcess,
                        icon: const Icon(Icons.block),
                        label: const Text('Jalankan Sync (UI Akan Freeze)'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2. Dengan Async (Future / Non-Blocking)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Status: $_statusAsync'),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _isLoadingAsync ? null : _runAsyncProcess,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Jalankan Async (UI Tetap Smooth)'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '3. Stream (Aliran Data)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            setState(() {
                              _streamKey = UniqueKey(); // Re-trigger Stream
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    StreamBuilder<int>(
                      key: _streamKey,
                      stream: _generateStreamData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Stream: Menunggu data pertama...');
                        } else if (snapshot.hasData) {
                          return Text(
                            'Data Diterima Realtime: Angka ${snapshot.data} / 5',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return const Text(
                            'Stream: Selesai! Semua data terkirim.',
                          );
                        }
                        return const Text('Stream belum aktif.');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
