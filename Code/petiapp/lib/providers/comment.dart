import 'package:dio/dio.dart';
import 'package:petiapp/services/auth.dart';

class CommentProvider {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://157.245.29.139/post/comment',
      headers: {'Authorization': 'Bearer ${AuthService.to.token}'},
      validateStatus: (status) => status! < 500,
    ),
  );
  // )..interceptors.add(InterceptorsWrapper(
  //     onError: (e, handler) {},
  //   ));

  Future<Response> list(String id, int page) async {
    dio.options.contentType = Headers.jsonContentType;
    return await dio.get(
      '/list/',
      queryParameters: {'postId': id, 'page': page},
    );
  }

  Future<Response> create(String id, String content) async {
    dio.options.contentType = Headers.jsonContentType;
    return await dio.post(
      '/create/',
      queryParameters: {
        'postId': id,
        'content': content,
      },
    );
  }
}
