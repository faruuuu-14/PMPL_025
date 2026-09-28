import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

enum ViewState { initial, loading, loaded, empty, error }

class DataProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // TODO 1: simpan _state, _users, _errorMessage + getter-nya di sini.
  ViewState get state => ViewState.initial;
  List<UserModel> get users => const [];
  String get errorMessage => '';

  Future<void> loadUsers({String? token}) async {
    // TODO 2: alur: loading + notify → fetchUsers via _apiService →
    // kosong? empty : loaded → error? set pesan + state error.
    // Jangan lupa notifyListeners() di akhir.
    await _apiService.fetchUsers(token: token, page: 1);
  }
}