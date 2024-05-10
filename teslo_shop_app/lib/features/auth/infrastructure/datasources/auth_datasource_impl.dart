import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';

import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';


class AuthDatasourceImpl extends AuthDatasource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.baseUrl,
    ),
  );

  @override
  Future<User> checkAuthStatus(String token) async {
    
    try {
      final response = await dio.get('/auth/check-status',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        ),
      );

      final user = UserMapper.userJsonToEntity(response.data);

      return user;

    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
          'Invalid token',
          401
        );
      }

      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });

      final user = UserMapper.userJsonToEntity(response.data);

      return user;

    } on DioException catch (e) {

      if (e.response?.statusCode == 401) {
        throw CustomError(
          e.response?.data['message'] ?? 'Invalid credentials',
          401
        );
      }

      if (e.type == DioExceptionType.receiveTimeout) {
        throw CustomError('Check internet connection', 401);
      }

      throw Exception();
    } catch (e) {
      throw Exception();
    }

  }

  @override
  Future<User> register(String email, String password, String fullname) async {
    
    try {

      final response = await dio.post('/auth/register', data: {
        'email': email,
        'password': password,
        'fullName': fullname
      });

      final user = UserMapper.userJsonToEntity(response.data);

      return user;
      
    } on DioException catch (e) {

      if (e.response?.statusCode == 401) {
        throw CustomError(
          e.response?.data['message'] ?? 'Invalid fields',
          401
        );
      }

      if (e.type == DioExceptionType.receiveTimeout) {
        throw CustomError('Check internet connection', 401);
      }

      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }



}