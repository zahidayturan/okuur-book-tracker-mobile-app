import 'package:get_storage/get_storage.dart';

class OkuurLocalStorage {

  static final OkuurLocalStorage _instance = OkuurLocalStorage._internal();

  factory OkuurLocalStorage() {
    return _instance;
  }

  OkuurLocalStorage._internal();


  final GetStorage _storage = GetStorage();


  final String _themeKey = 'theme';
  final String _languageKey = 'language';
  final String _dailyGoalKey = 'dailyGoal';

  final String _activeUserUidKey = 'activeUserUid';


  final int _defaultTheme = 2; // default theme (0=light, 1=dark, 2=system)
  final String _defaultLanguage = 'null'; // default language (tr,en)
  final int _defaultDailyGoal = 50;


  Future<void> saveTheme(int theme) async {
    await _storage.write(_themeKey, theme);
  }

  Future<void> saveLanguage(String language) async {
    await _storage.write(_languageKey, language);
  }

  Future<void> saveDailyGoal(int dailyGoal) async {
    await _storage.write(_dailyGoalKey, dailyGoal);
  }


  int getTheme() {
    return _storage.read<int>(_themeKey) ?? _defaultTheme;
  }

  String getLanguage() {
    return _storage.read<String>(_languageKey) ?? _defaultLanguage;
  }

  int getDailyGoal() {
    return _storage.read<int>(_dailyGoalKey) ?? _defaultDailyGoal;
  }


  Future<void> removeTheme() async {
    await _storage.remove(_themeKey);
  }

  Future<void> removeLanguage() async {
    await _storage.remove(_languageKey);
  }

  Future<void> removeDailyGoal() async {
    await _storage.remove(_dailyGoalKey);
  }

  Future<void> saveActiveUserUid(String uid) async {
    await _storage.write(_activeUserUidKey, uid);
  }

  String? getActiveUserUid() {
    return _storage.read<String>(_activeUserUidKey);
  }

  Future<void> removeActiveUserUid() async {
    await _storage.remove(_activeUserUidKey);
  }


  Future<void> clearAll() async {
    await _storage.erase();
  }
}