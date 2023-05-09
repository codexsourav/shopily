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
      return [];
    }
  }

  Future<bool> resetCart(data) async {
    return await storage.setStorege(key: storageName, data: data ?? []);
  }

  // add products on cart
  Future<bool> manageItem(product) async {
    var list = await getCart();
    if (list.any((element) => element['productId'] == product['_id'])) {
      list.removeWhere((element) => element['productId'] == product['_id']);
      await storage.setStorege(key: storageName, data: list);
      return false;
    } else {
      list.add({
        "_id": product['_id'],
        "productId": product['_id'],
        "quantity": 1,
        "product": product
      });
      await storage.setStorege(key: storageName, data: list);
      return true;
    }
  }

  Future update({id, qunt}) async {
    List myList = await getCart();
    var idToUpdate = id;
    var newquantity = qunt;
    List updatedList = myList.map((map) {
      if (map["productId"] == idToUpdate) {
        return {...map, "quantity": int.parse(newquantity)};
      }
      return map;
    }).toList();
    return await storage.setStorege(key: storageName, data: updatedList);
  }
}
