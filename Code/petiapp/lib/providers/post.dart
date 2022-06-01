import 'package:dio/dio.dart';
import 'package:petiapp/services/auth.dart';

class PostProvider {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://157.245.29.139/post',
      headers: {'Authorization': 'Bearer ${AuthService.to.token}'},
      validateStatus: (status) => status! < 500,
    ),
  );

  Future watchGallary(int key) async =>
      await dio.get('/watch/gallary/', queryParameters: {'page': key});

  Future watchTv(int key) async =>
      await dio.get('/watch/tv/', queryParameters: {'page': key});

  Future createImage({
    required String file,
    required String petId,
    required String color,
    required String? caption,
  }) async {
    dio.options.contentType = Headers.formUrlEncodedContentType;
    FormData dataForm = FormData.fromMap({
      'file': await MultipartFile.fromFile(file),
      'creator_id': petId,
      'color': color,
      'caption': caption,
    });
    return await dio.post('/create/image/', data: dataForm);
  }

  Future createVideo({
    required String file,
    required String thumbinal,
    required String petId,
    required String color,
    required String? caption,
  }) async {
    dio.options.contentType = Headers.formUrlEncodedContentType;
    FormData dataForm = FormData.fromMap({
      'file': await MultipartFile.fromFile(file),
      'thumbinal': await MultipartFile.fromFile(thumbinal),
      'creator_id': petId,
      'color': color,
      'caption': caption,
    });
    return await dio.post('/create/video/', data: dataForm);
  }

  like(String id) async =>
      await dio.post('/like/', queryParameters: {'id': id});

  delete(String id) async =>
      await dio.delete('/delete/', queryParameters: {'id': id});
}
