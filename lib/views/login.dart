import 'package:flutter/material.dart';
import 'package:miloficiosapp/providers/user_provider.dart';
import 'package:miloficiosapp/utils/http_helper.dart';
import 'package:miloficiosapp/views/register.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String error = "";
  bool inAsyncCall = false;

  void iniciarSesion() async {
    setState(() {
      inAsyncCall = true;
    });

    String token = await HttpHelper()
        .iniciarSesion(controllerUsuario.text, controllerPassword.text);

    setState(() {
      inAsyncCall = false;
    });
    print("token p" + token);
    if (token.length > 0) {
      Provider.of<UserProvider>(context, listen: false).saveUserData(token);
    } else {
      setState(() {
        error = "Credenciales incorrectas";
      });
      controllerPassword.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://st2.depositphotos.com/1752173/12158/v/950/depositphotos_121587406-stock-illustration-seamless-pattern-construction-tools-vector.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Mil Oficios",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: controllerUsuario,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle),
                            hintText: "Usuario",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.yellow, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: controllerPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Password",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.yellow, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(error),
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            iniciarSesion();
                          },
                          child: Text(
                            "Iniciar Sesión",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 760, left: 100),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    "¿ No tienes cuenta ? Registrate",
                    style: TextStyle(color: Colors.yellow),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
