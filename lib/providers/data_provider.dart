import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/api_service.dart';

enum ViewState { initial, loading, loaded, empty, error }

class DataProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  ViewState _state = ViewState.initial;
  List<UserModel> _users = [];
  String _errorMessage = '';

  ViewState get state => _state;
  List<UserModel> get users => List.unmodifiable(_users);
  String get errorMessage => _errorMessage;

  Future<void> loadUsers({String? token}) async {
    _state = ViewState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _users = await _apiService.fetchUsers(token: token);
      _state = _users.isEmpty ? ViewState.empty : ViewState.loaded;
    } catch (error) {
      _errorMessage = error.toString();
      _state = ViewState.error;
    }

    notifyListeners();
  }
}
