import 'dart:io';
import 'package:dio/dio.dart';
import 'package:petiapp/models/pet.dart';
import 'package:petiapp/services/auth.dart';

class PetProvider {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://157.245.29.139/pet',
      headers: {'Authorization': 'Bearer ${AuthService.to.token}'},
      validateStatus: (status) => status! < 500,
    ),
  );

  Future<Response> owned({String? userId}) =>
      dio.get('/owned/', queryParameters: {if (userId != null) 'id': userId});

  Future<Response> read(String id) async =>
      await dio.get('/read/', queryParameters: {'id': id});

  Future<Response> posts(String id, int page) async =>
      await dio.get('/posts/', queryParameters: {'id': id, 'page': page});

  Future<Response> delete(String id) async =>
      await dio.delete('/delete/', queryParameters: {'id': id});

  Future<Response> follow(String id) async =>
      await dio.get('/follow/', queryParameters: {'id': id});

  Future<Response> create(Pet pet, File file) async {
    dio.options.contentType = Headers.formUrlEncodedContentType;
    return dio.post(
      '/create/',
      data: FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        'name': pet.name,
        'gender': pet.gender,
        'birthday': pet.birthday,
        'type': pet.type,
        'want_marraige': pet.wantMarraige,
        if (pet.breed != null) 'breed': pet.breed,
      }),
    );
  }

  Future<Response> update(
    String id, {
    String? name,
    String? gender,
    String? birthday,
    String? type,
    String? breed,
    bool? wantMarraige,
  }) async =>
      await dio.put(
        '/update/',
        queryParameters: {'id': id},
        data: {
          if (name != null) 'name': name,
          if (gender != null) 'gender': gender,
          if (birthday != null) 'birthday': birthday,
          if (type != null) 'type': type,
          if (breed != null) 'breed': breed,
          if (wantMarraige != null) 'want_marraige': wantMarraige,
        },
      );

  Future<Response> updateAvatar(String id, String file) async => await dio.put(
        '/update/avatar/',
        queryParameters: {'id': id},
        data: FormData.fromMap({'file': await MultipartFile.fromFile(file)}),
      );
}
