import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

const String OAuthKey = "No key";

Future<String?> _getIAMToken({required String oauth}) {
  return Future((){return null;});
}

Future<void> initCloud() async {
  String? iamToken = await _getIAMToken(oauth: OAuthKey);
  if (iamToken == null) {
    log("Yandex did not responded with IAM token. Check account, oauth key or internet connection");
    throw Exception("No token provided");
  } 
}


