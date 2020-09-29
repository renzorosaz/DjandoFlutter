import 'package:flutter/material.dart';
import 'package:miloficiosapp/providers/user_provider.dart';
import 'package:miloficiosapp/views/listar_categorias.dart';
import 'package:miloficiosapp/views/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    if (Provider.of<UserProvider>(context, listen: false).token == null)
      Provider.of<UserProvider>(context, listen: false).fetchUserData();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ( Provider.of<UserProvider>(context).token !=null && 
              Provider.of<UserProvider>(context).token.length > 0)
          ? Categorias()
          : Login(),
    );
  }
}
