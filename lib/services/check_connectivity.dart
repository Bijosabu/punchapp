import 'dart:io';
import 'package:http/http.dart' as http;

class CheckConnectivity {
  
  Future<bool> check() async {
    try {
      http.Response response = await http.get(Uri.parse("https://www.google.com/"));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      return false;
    } catch (e) {
      return false;
    }
  }
}