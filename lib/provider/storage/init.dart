import 'package:localstorage/localstorage.dart';

class LocalDB {
  final LocalStorage storage = LocalStorage('shopilydb');
  LocalDB._privateCostractor();
  static final LocalDB instense = LocalDB._privateCostractor();
// for get data
  Future getStorege(key) async {
    try {
      if (storage.getItem(key) == null) {
        await storage.setItem(key, {});
        return {};
      } else {
        return storage.getItem(key);
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

// for set data
  Future<bool> setStorege({required key, required data}) async {
    try {
      await storage.setItem(key, data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

// for delete data
  Future<bool> deleteStorege(key) async {
    try {
      await storage.deleteItem(key);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
