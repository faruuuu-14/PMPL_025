import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/note_model.dart';
import '../services/firestore_service.dart';
import 'data_provider.dart';

class NotesProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  ViewState _state = ViewState.initial;
  List<NoteModel> _notes = <NoteModel>[];
  String _errorMessage = '';
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  ViewState get state => _state;
  List<NoteModel> get notes => List.unmodifiable(_notes);
  String get errorMessage => _errorMessage;

  void startListening() {
    if (_subscription != null) {
      return;
    }

    _state = ViewState.loading;
    _errorMessage = '';
    notifyListeners();

    _subscription = _firestoreService.notesStream.listen(
      (snapshot) {
        final updatedNotes = snapshot.docs
            .map(NoteModel.fromSnapshot)
            .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        _notes = updatedNotes;
        _state = updatedNotes.isEmpty ? ViewState.empty : ViewState.loaded;
        _errorMessage = '';
        notifyListeners();
      },
      onError: (Object error) {
        _state = ViewState.error;
        _errorMessage = _mapError(error);
        notifyListeners();
      },
    );
  }

  Future<void> addNote({required String title, required String content}) async {
    try {
      await _firestoreService.addNote(title: title, content: content);
    } catch (error) {
      _state = ViewState.error;
      _errorMessage = _mapError(error);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String content,
  }) async {
    try {
      await _firestoreService.updateNote(
        id: id,
        title: title,
        content: content,
      );
    } catch (error) {
      _state = ViewState.error;
      _errorMessage = _mapError(error);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _firestoreService.deleteNote(id);
    } catch (error) {
      _state = ViewState.error;
      _errorMessage = _mapError(error);
      notifyListeners();
      rethrow;
    }
  }

  String _mapError(Object error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return 'Akses Firestore ditolak. Aktifkan Test Mode di Firebase Console.';
        case 'failed-precondition':
          return 'Firestore memerlukan index komposit. Hapus orderBy() atau buat index yang diminta.';
        default:
          return error.message ?? 'Terjadi kesalahan Firestore.';
      }
    }

    return error.toString();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
