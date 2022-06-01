import 'package:dio/dio.dart';
import 'package:petiapp/services/auth.dart';

class RequestProvider {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://157.245.29.139/request',
      headers: {'Authorization': 'Bearer ${AuthService.to.token}'},
      validateStatus: (status) => status! < 500,
    ),
  );

  Future<Response> newRequests(String? petId) async => await dio
      .get('/new/', queryParameters: {if (petId != null) 'pet_id': petId});

  Future<Response> myRequests(String? petId) async => await dio
      .get('/my/', queryParameters: {if (petId != null) 'pet_id': petId});

  Future<Response> acceptedRequests(String? petId) async => await dio
      .get('/accepted/', queryParameters: {if (petId != null) 'pet_id': petId});

  Future<Response> completedRequests(String? petId) async =>
      await dio.get('/completed/',
          queryParameters: {if (petId != null) 'pet_id': petId});

  Future<Response> refusedRequests(String? petId) async => await dio
      .get('/refused/', queryParameters: {if (petId != null) 'pet_id': petId});

  Future<Response> delete(String id) async =>
      await dio.delete('/delete/', queryParameters: {'id': id});

  Future<Response> accept(String id, isAccepted) async => await dio
      .post('/accept/', queryParameters: {'id': id, 'is_accepted': isAccepted});

  Future<Response> complete(String id) async =>
      await dio.post('/complete/', queryParameters: {'id': id});

  Future<Response> create(
    String receiver,
    String sender,
  ) async =>
      await dio.post(
        '/create/',
        queryParameters: {
          'receiver': receiver,
          'sender': sender,
        },
      );
}
