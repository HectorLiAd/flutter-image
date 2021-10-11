import 'package:flutter/material.dart';
import 'package:local_auth_fingerprint/apis/api_imagen.dart';
import 'package:local_auth_fingerprint/models/modelo_imagen.dart';
import 'package:local_auth_fingerprint/ui/imagen_carg.dart';
import 'package:local_auth_fingerprint/ui/imagen_form.dart';
import 'package:provider/provider.dart';

class ImagenUI extends StatefulWidget {
  @override
  _ImagenUIState createState() => _ImagenUIState();
}

class _ImagenUIState extends State<ImagenUI> {
  @override
  void initState() {
    super.initState();
  }

  Future<Null> onGoBack() async {
    setState(() { });
  }
  Future onGoBack1(dynamic value) {
    setState(() {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Second Route"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: FutureBuilder<List<ModeloImagen>>(
        future: Provider.of<ImagenApi>(context, listen: true).getImagenes(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ModeloImagen>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<ModeloImagen> persona = snapshot.data;
            return _crearLista(persona);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImagenForm()),
          ).then(onGoBack1);
        },
      ),
    );
  }

  Widget _crearLista(List<ModeloImagen> imagenObj) {
    final lista = ListView.builder(
      itemCount: imagenObj.length,
      itemBuilder: (BuildContext context, int index) {
        final imagen = imagenObj[index];
        return ImageCard(imageModel: imagen);
      },
    );


    return RefreshIndicator(
      onRefresh: onGoBack,
      child: lista,
    );
  }

}
