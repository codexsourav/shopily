import 'init.dart';

class CartStorage {
  final storage = LocalDB.instense;
  String storageName = 'cart';
  // for get products on a cart
  Future getCart() async {
    try {
      var item = await storage.getStorege(storageName);
      if (item.isNotEmpty) {
        return item;
      } else {
        await storage.setStorege(key: storageName, data: []);
        return [];
      }
    } catch (e) {
      print(e);
    }
  }

  // add products on cart
  Future<bool> manageItem(product) async {
    var list = await getCart();

    if (list.any((element) => element == product['_id'])) {
      list.removeWhere((element) => element == product['_id']);
      await storage.setStorege(key: storageName, data: list);
      return false;
    } else {
      list.add(product['_id']);
      await storage.setStorege(key: storageName, data: list);
      return true;
    }
  }
}
