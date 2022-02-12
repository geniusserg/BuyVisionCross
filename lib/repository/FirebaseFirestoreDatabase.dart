import 'dart:ffi';

import '../models/ItemModel.dart';

class FirebaseFirestoreDatabase {
  Future<bool> saveItem({required ItemModel item}) {
    print("saved model to firestore database");
    //to implemt
    return Future(() => true);
  }
}
