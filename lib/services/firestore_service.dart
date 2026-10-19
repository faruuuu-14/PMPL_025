import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get notesCollection =>
      _firestore.collection('notes');

  Stream<QuerySnapshot<Map<String, dynamic>>> get notesStream =>
      notesCollection.snapshots();

  Future<void> addNote({
    required String title,
    required String content,
  }) async {
    final cleanTitle = title.trim();
    final cleanContent = content.trim();

    if (cleanTitle.isEmpty && cleanContent.isEmpty) {
      throw const FormatException('Judul dan isi catatan tidak boleh kosong.');
    }

    await notesCollection.add({
      'title': cleanTitle,
      'content': cleanContent,
      'createdAt': Timestamp.now(),
    });
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String content,
  }) async {
    final cleanTitle = title.trim();
    final cleanContent = content.trim();

    if (cleanTitle.isEmpty && cleanContent.isEmpty) {
      throw const FormatException('Judul dan isi catatan tidak boleh kosong.');
    }

    await notesCollection.doc(id).update({
      'title': cleanTitle,
      'content': cleanContent,
      'createdAt': Timestamp.now(),
    });
  }

  Future<void> deleteNote(String id) async {
    await notesCollection.doc(id).delete();
  }
}
