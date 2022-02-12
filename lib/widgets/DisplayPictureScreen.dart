import 'dart:async';
import 'dart:io';

import 'package:buy_vision_crossplatform/models/ItemModel.dart';
import 'package:buy_vision_crossplatform/widgets/ProductDisplayScreen.dart';
import 'package:flutter/material.dart';
import 'package:buy_vision_crossplatform/repository/FirebaseFirestoreDatabase.dart';
import 'package:buy_vision_crossplatform/services/FirebaseRecognitionService.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final FirebaseRecognitionService _mService = FirebaseRecognitionService();
  final FirebaseFirestoreDatabase _mDatabase = FirebaseFirestoreDatabase();
  final Future<String> recognitionFuture;

  DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.recognitionFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Column(
          children: [
            FutureBuilder<String>(
              future: recognitionFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var item =
                      _createItem(data: snapshot.data!, imagePath: imagePath);
                  _saveItemToDatabase(model: item);
                  return ProductDisplayScreen(model: item);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            ),
          ],
        ));
  }

  ItemModel _createItem({required String data, required imagePath}) {
    return ItemModel(text: data, id: 1, date: DateTime.now(), photo: imagePath);
  }

  Future<bool> _saveItemToDatabase({required ItemModel model}) {
    var saveToDatabaseTask = _mDatabase.saveItem(item: model);
    return saveToDatabaseTask;
  }
}
