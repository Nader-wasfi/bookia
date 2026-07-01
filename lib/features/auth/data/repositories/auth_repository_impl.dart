import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> login(AuthEntity entity) async {
    final loginModel = LoginRequestModel(
      email: entity.email,
      password: entity.password,
    );
    
    final response = await remoteDataSource.login(loginModel);
    if (response.statusCode != 200) {
      throw Exception(response.data['message'] ?? 'فشل تسجيل الدخول');
    }
  }

  @override
  Future<void> register(AuthEntity entity) async {
    final registerModel = RegisterRequestModel(
      name: entity.name ?? '',
      email: entity.email,
      password: entity.password,
      passwordConfirmation: entity.password, 
    );

    final response = await remoteDataSource.register(registerModel);
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.data['message'] ?? 'فشل إنشاء الحساب');
    }
  }
}