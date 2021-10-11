part of 'api_imagen.dart';

class _ImagenApi implements ImagenApi {
  _ImagenApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= "http://192.168.2.20:8080";
  }

  final Dio _dio;
  String baseUrl;

  @override
  getImagenes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
      '/api/imagenes/',
      queryParameters: queryParameters,
      options: RequestOptions(
          method: 'GET',
          headers: <String, dynamic>{ /*"Authorization":tokenx*/
          },
          extra: _extra,
          baseUrl: baseUrl
      ),
      // data: _data
    );
    var value = await  _result.data
        .map((dynamic i) => ModeloImagen.fromJson(i as Map<String, dynamic>))
        .toList();

    return await Future.value(value);
  }

  @override
  crearImagen(imagen) async {
    // ArgumentError.checkNotNull(imagen, 'imagen');
    // final prefs = await SharedPreferences.getInstance();
    // var tokenx=prefs.getString("token");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(imagen.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/api/imagenes/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{ /*"Authorization":tokenx*/},
            extra: _extra,
            baseUrl: baseUrl
        ),
        data: _data);
    final value = await ModeloImagen.fromJson(_result.data);
    return await Future.value(value);
  }
}
