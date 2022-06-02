import 'dart:io';

Future<bool> hasInternet() async{
  try {
    final result = await InternetAddress.lookup('example.com');
    if (!(result.isNotEmpty && result[0].rawAddress.isNotEmpty)) {
      return false;
    }
  } on SocketException catch (_) { return false;}
  return true;
}
