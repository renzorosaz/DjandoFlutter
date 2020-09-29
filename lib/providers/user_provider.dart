import 'package:flutter/widgets.dart';
import 'package:miloficiosapp/utils/session_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {

  String token= "";

  fetchUserData() async{
    token = SessionHelper().token;
    var prefs= await SharedPreferences.getInstance();
    token= prefs.getString("token");
    notifyListeners();
  }
  saveUserData(String token) async{
    this.token =token;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    print("dino"+token);
    notifyListeners();

  }

}
