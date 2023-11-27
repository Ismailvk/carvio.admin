import 'package:shared_preferences/shared_preferences.dart';

class Sharedpref {
  Sharedpref._();
  static final _instance = Sharedpref._();
  static Sharedpref get instance => _instance;

  static const String token = 'token';

  late SharedPreferences storage;

  initStorage() async {
    storage = await SharedPreferences.getInstance();
  }

  storeToken(String tokenn) async {
    await storage.setString(token, tokenn);
  }

  String? getToken() {
    return storage.getString(token);
  }

  removeToken() async {
    await storage.remove(token);
  }
}
