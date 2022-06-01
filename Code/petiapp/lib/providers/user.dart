import 'package:dio/dio.dart';
import 'package:petiapp/services/auth.dart';

class UserProvider {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://157.245.29.139/user',
      headers: {
        if (AuthService.to.isAuthenticated.value)
          'Authorization': 'Bearer ${AuthService.to.token}'
      },
      validateStatus: (status) => status! < 500,
    ),
  );

  Future<Response> isExist(String email) =>
      dio.get('/is_exist/', queryParameters: {'email': email});

  // Future<Response> auth(String email) => get(
  //       'https://oauth2.googleapis.com/tokeninfo',
  //       query: {'access_token': email},
  //     );

  Future<Response> signin(String email, String pass) => dio.post(
        '/auth/',
        data: FormData.fromMap({
          "username": email,
          "password": pass,
        }),
      );

  Future<Response> facebook({
    required String clientId,
    required String email,
    required String accessToken,
    required String username,
    required String avatar,
  }) =>
      dio.post(
        '/auth/facebook/',
        queryParameters: {
          'username': username,
          'avatar': avatar,
        },
        data: FormData.fromMap({
          "client_id": clientId,
          "username": email,
          "password": accessToken,
        }),
      );

  // Future<Response> signinWithGoogle(String email, String token) => post(
  //       '/auth/google/',
  //       FormData({
  //         "username": email,
  //         "password": token,
  //       }),
  //     );

  Future<Response> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String pass,
    required Map location,
    String? phone,
  }) =>
      dio.post('/create/', data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': pass,
        if (phone != null) 'phone': phone,
        'location': location,
      });

  Future<Response> read(String userId) async =>
      await dio.get('/read/', queryParameters: {'id': userId});

  Future<Response> updateAvatar(String photo) async => await dio.put(
      "/update/avatar/",
      data: FormData.fromMap({'file': await MultipartFile.fromFile(photo)}));

  Future<Response> updateLastLogin() async =>
      await dio.post('/update/last_login/');

  Future<Response> updateAccount({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) async =>
      await dio.put('/update/', data: {
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
      });

  Future<Response> updateLocation({
    String? iso,
    String? country,
    String? city,
    String? region,
    double? latitude,
    double? longitude,
  }) async =>
      await dio.put('/update/location/', data: {
        if (iso != null) "iso": iso,
        if (country != null) "country": country,
        if (region != null) "region": region,
        if (city != null) "city": city,
        if (latitude != null && longitude != null)
          'specifics': {
            'coordinates': [longitude, latitude],
          }
        else
          'specifics': null,
      });
}
