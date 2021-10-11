import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:local_auth_fingerprint/models/modelo_imagen.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

part 'api_imagen.g.dart';

@RestApi(baseUrl: "http://192.168.2.20:8080")
abstract class ImagenApi {
  factory ImagenApi(Dio dio, {String baseUrl})=_ImagenApi;

  static ImagenApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ImagenApi(dio);
  }

  @GET("/api/imagenes/")
  Future<List<ModeloImagen>> getImagenes();

  @POST("/api/imagenes/")
  Future<ModeloImagen> crearImagen(@Body() ModeloImagen imagen);
/*
  @DELETE("/api/persona/{id}")
  Future<ModeloMsg> deletePersona(@Path("id") String id);

  @PATCH("/api/persona/{id}")
  Future<ModeloMsg> updatePersona(@Path("id")String id, @Body() ModeloPersona persona);

  @POST("/api/persona")
  Future<ModeloMsg> crearPersona(@Body() ModeloPersona persona);

  @POST("/api/auth")
  Future<ModeloToken> login(@Body() ModeloUser usuario);
*/
/*@GET("/api/estadis")
  Future<List<ModeloPersona>> getPredictionChart();

  @GET("/api/cov/{cantidad}")
  Future<List<ModeloPersona>> getPredictionCant(@Path(" cantidad") int cantidad);*/

}