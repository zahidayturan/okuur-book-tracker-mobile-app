import 'package:get_storage/get_storage.dart';

class OkuurLocalStorage {
  static final OkuurLocalStorage _instance = OkuurLocalStorage._internal();

  factory OkuurLocalStorage(){
    return _instance;
  }

  OkuurLocalStorage._internal();

  final _storage = GetStorage();

  Future<void> saveData<Okuur>(String key, Okuur value) async{
    await _storage.write(key, value);
  }

  Okuur? readData<Okuur>(String key){
    return _storage.read<Okuur>(key);
  }

  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
  


}