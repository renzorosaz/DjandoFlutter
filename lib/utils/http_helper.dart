import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:miloficiosapp/models/banner.dart';
import 'package:miloficiosapp/models/categoria.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpHelper {
  String urlBase = "http://192.168.1.3:8000/API/";

  Future<List<Categoria>> fetchCategorias() async {
    var response = await http.get(urlBase + "categoriasList/");

    print("rep" + response.body);
    List categoriasJson = jsonDecode(response.body);

    return categoriasJson.map((e) => Categoria.fromJson(e)).toList();
  }

  Future<List<BannerPublicitario>> fetchBannersPublicitarios() async {
    var response = await http.get(urlBase + "bannerspublicitarios/");
    List categoriasJson = jsonDecode(response.body);

    return categoriasJson.map((e) => BannerPublicitario.fromJson(e)).toList();
  }

  Future<String> iniciarSesion(String username, String password) async {
    var response = await http.post(urlBase + "token-auth/",
        body: {"username": username, "password": password});
    print(response.body.toString());

    print("status code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      String token = jsonDecode(response.body)["token"];
      print("status code token" + token);
      return token;
    }
    return "";
  }

  Future registrarUsuario(String username, String password, String correo,
      String nombre, String apellido, String dni) async {
    var response = await http.post(urlBase + "clienteRegister/", body: {
      "username": username,
      "password": password,
      "email": correo,
      "first_name": nombre,
      "last_name": apellido,
      "dni": dni
    });

    print(response.body);
  }

   Future consultarUsuario(String token) async {
    var response = await http.get(urlBase + "clienteRetrieve/",
        headers: {"Authorization": "JWT " + token});
    print(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("username", json["username"]);
      prefs.setString("email", json["email"]);
      prefs.setString("first_name", json["first_name"]);
      prefs.setString("last_name", json["last_name"]);
      prefs.setString("dni", json["dni"]);
    }
  }
}
