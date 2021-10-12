import 'package:flutter/material.dart';
import 'package:local_auth_fingerprint/apis/api_imagen.dart';
import 'package:local_auth_fingerprint/auth/auth_path.dart';
import 'package:local_auth_fingerprint/ui/imagen_main.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<ImagenApi>(
        create: (_) => ImagenApi.create(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Huella dactilar',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // home: AuthPath()
            home: AuthPath()
        )
    );
  }

}