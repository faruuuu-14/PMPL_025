import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory NoteModel.fromSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    final rawTimestamp = data['createdAt'];
    final createdAt = rawTimestamp is Timestamp
        ? rawTimestamp.toDate()
        : DateTime.now();

    return NoteModel(
      id: snapshot.id,
      title: (data['title'] as String?)?.trim() ?? '',
      content: (data['content'] as String?)?.trim() ?? '',
      createdAt: createdAt,
    );
  }
}
