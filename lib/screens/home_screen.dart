import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../providers/auth_provider.dart';
import '../providers/data_provider.dart';
import '../providers/notes_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotesProvider>(context, listen: false).startListening();
    });
  }

  Future<void> _reload() async {
    Provider.of<NotesProvider>(context, listen: false).startListening();
  }

  Future<void> _deleteNote(NoteModel note) async {
    try {
      await Provider.of<NotesProvider>(context, listen: false).deleteNote(note.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Catatan berhasil dihapus.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<void> _showNoteDialog({NoteModel? note}) async {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(note == null ? 'Tambah Catatan' : 'Edit Catatan'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Judul',
                    hintText: 'Contoh: Belanja',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contentController,
                  minLines: 4,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: 'Isi Catatan',
                    hintText: 'Tuliskan detail catatan Anda...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(note == null ? 'Simpan' : 'Update'),
            ),
          ],
        );
      },
    );

    if (!mounted) {
      titleController.dispose();
      contentController.dispose();
      return;
    }

    if (result != true) {
      titleController.dispose();
      contentController.dispose();
      return;
    }

    final title = titleController.text.trim();
    final content = contentController.text.trim();
    titleController.dispose();
    contentController.dispose();

    try {
      if (note == null) {
        await Provider.of<NotesProvider>(context, listen: false).addNote(
          title: title,
          content: content,
        );
      } else {
        await Provider.of<NotesProvider>(context, listen: false).updateNote(
          id: note.id,
          title: title,
          content: content,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            note == null ? 'Catatan baru berhasil dibuat.' : 'Catatan berhasil diperbarui.',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () =>
                Provider.of<AuthProvider>(context, listen: false).logout(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNoteDialog(),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Note'),
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          switch (notesProvider.state) {
            case ViewState.loading:
              return const Center(child: CircularProgressIndicator());
            case ViewState.error:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                      const SizedBox(height: 12),
                      Text(
                        notesProvider.errorMessage,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _reload,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              );
            case ViewState.empty:
              return RefreshIndicator(
                onRefresh: _reload,
                child: ListView(
                  children: const [
                    SizedBox(height: 120),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.sticky_note_2_outlined, size: 52, color: Colors.grey),
                          SizedBox(height: 12),
                          Text('Belum ada catatan. Tambahkan satu terlebih dahulu.'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            case ViewState.loaded:
              return RefreshIndicator(
                onRefresh: _reload,
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: notesProvider.notes.length,
                  itemBuilder: (context, index) {
                    final note = notesProvider.notes[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () => _showNoteDialog(note: note),
                        title: Text(
                          note.title.isEmpty ? 'Catatan Tanpa Judul' : note.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${note.content.isEmpty ? 'Tidak ada isi...' : note.content}\n${_formatDate(note.createdAt)}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          tooltip: 'Hapus catatan',
                          onPressed: () => _deleteNote(note),
                        ),
                      ),
                    );
                  },
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  String _formatDate(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final year = value.year;
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }
}
