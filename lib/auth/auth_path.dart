import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_fingerprint/home_page.dart';
import 'package:local_auth_fingerprint/ui/imagen_main.dart';

class AuthPath extends StatefulWidget {
  const AuthPath({Key key}) : super(key: key);

  @override
  _AuthPathState createState() => _AuthPathState();
}

class _AuthPathState extends State<AuthPath> {

  bool _hasBioSensor;

  LocalAuthentication authentication = LocalAuthentication();


  Future<void> _checkBio() async{
    try{
      _hasBioSensor  = await authentication.canCheckBiometrics;
      print("Huella dactilar activada");
      print(_hasBioSensor);

      if(_hasBioSensor){
        _getAuth();
      }

    }on PlatformException catch(e){
      print(e);
    }
  }

  Future<void> _getAuth() async{
    bool isAuth = false;

    //loaded a dialog to scan fingerprint
    try{
      isAuth = await authentication.authenticateWithBiometrics(
        localizedReason: 'Oe pon el dedo del dueño pe causita',
        // biometricOnly: true,
        useErrorDialogs: true,
        stickyAuth: true
      );

      //if fingerprint scan match then
      //isAuth = true
      // therefore will navigate user to WelcomePage/HomePage of the App
      if(isAuth){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>ImagenUI()));
      }

    }on PlatformException catch(e){
      print(e);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     // call method immediately when app launch
    _checkBio();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Oe pon el dedo del dueño',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  child: const Text('Huellita dactilar'),
                  onPressed: () {
                    _checkBio();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(), primary: Colors.green))),
        ],
      ),
    );
  }
}
