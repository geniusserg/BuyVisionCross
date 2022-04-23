import 'dart:ffi';

import '../models/ItemModel.dart';

class FirebaseFirestoreDatabase {
  Future<bool> saveItem({required ItemModel item}) {
    return Future(() => true);
  }
}
