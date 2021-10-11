import 'dart:io';

import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:local_auth_fingerprint/apis/api_imagen.dart';
import 'package:local_auth_fingerprint/models/modelo_imagen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


import 'dart:io' as Io;
import 'dart:convert';



class ImagenForm extends StatefulWidget {
  @override
  _ImagenFormState createState() => _ImagenFormState();
}

class _ImagenFormState extends State<ImagenForm> {
  String _imagePath = '';
  final _picker = ImagePicker();
  String _imagenBase64= '';
  String _titulo ='';
  String _detalle = '';

  // var _data = [];

  @override
  void initState() {
    super.initState();

  }

  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Second Route"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              // color: AppTheme.nearlyWhite,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    (_imagePath != '')
                        ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Image.file(File(_imagePath)),
                    )
                        : Container(),
                    _crearImage(),
                    _buildTitulo(),
                    _buildDetalle(),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(onPressed: (){
                              Navigator.pop(context, true);
                            }, child: Text('Cancelar')),
                            TextButton(
                              onPressed: () async {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Procesando Datos'),
                                    ),
                                  );

                                  _formKey.currentState.save();
                                  final bytes = await Io.File(_imagePath).readAsBytesSync();
                                  String img64 = await base64Encode(bytes);

                                  ModeloImagen modelImagen = ModeloImagen();
                                  modelImagen.title = _titulo;
                                  modelImagen.detail = _detalle;
                                  modelImagen.image = img64.toString();


                                  var api = await Provider.of<ImagenApi>(context, listen: false).crearImagen(modelImagen);

                                  // print(api.toJson());
                                  setState(() { });
                                  Navigator.pop(context, true);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                      Text('No estan bien los campos ingresados'),
                                    ),
                                  );
                                }
                              },
                              child: const Text('Guardar'),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ))),
    );
  }

  //  Metodos


  Widget _crearImage(){
    return Container(
      padding: EdgeInsets.all(0),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue)),
        onPressed: () async {
          final pickedFile = await _picker.getImage(source: ImageSource.gallery);
          this._imagePath = pickedFile.path;
          setState(() {});
          /*if (pickedFile != null) {
            File croppedFile = await ImageCropper.cropImage(
                sourcePath: pickedFile.path,
                aspectRatioPresets: [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ],
                androidUiSettings: AndroidUiSettings(
                    toolbarTitle: 'Cropper',
                    toolbarColor: Colors.deepOrange,
                    toolbarWidgetColor: Colors.white,
                    initAspectRatio: CropAspectRatioPreset.original,
                    lockAspectRatio: false),
                iosUiSettings: IOSUiSettings(
                  minimumAspectRatio: 1.0,
                ));

            if (croppedFile != null) {
              setState(() {
                _imagePath = croppedFile.path;
              });
            }
          }*/
        },
        child: Text('Seleccione una imagen'),
      ),
    );

  }

  Widget _buildTitulo() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Titulo'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'El titulo es requerido';
        }
        return null;
      },
      onSaved: (String value) {
        this._titulo = value;
      },
    );
  }

  Widget _buildDetalle() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Detalle'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'El detalle es requerido';
        }
        return null;
      },
      onSaved: (String value) {
        this._detalle = value;
      },
    );
  }

}
