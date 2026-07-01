import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/register_use_case.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
  }) : super(AuthInitialState());

  void login(String email, String password) async {
    emit(AuthLoadingState());
    try {
      final entity = AuthEntity(email: email, password: password);
      await loginUseCase.call(entity);
      emit(AuthSuccessState("تم تسجيل الدخول بنجاح! 👋"));
    } catch (e) {
      emit(AuthErrorState(e.toString().replaceAll("Exception: ", "")));
    }
  }

  void register(String name, String email, String password) async {
    emit(AuthLoadingState());
    try {
      final entity = AuthEntity(name: name, email: email, password: password);
      await registerUseCase.call(entity);
      emit(AuthSuccessState("تم إنشاء الحساب بنجاح! 🚀"));
    } catch (e) {
      emit(AuthErrorState(e.toString().replaceAll("Exception: ", "")));
    }
  }
}