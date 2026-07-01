import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<void> login(AuthEntity entity);
  Future<void> register(AuthEntity entity);
}