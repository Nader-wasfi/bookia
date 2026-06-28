import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_sources/auth_remote_data_source.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/register_request_model.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRemoteDataSource _dataSource = AuthRemoteDataSource();

  AuthCubit() : super(AuthInitialState());

  void register(RegisterRequestModel model) async {
    emit(AuthLoadingState());
    try {
      final response = await _dataSource.register(model);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AuthSuccessState("تم إنشاء الحساب بنجاح! 🚀"));
      } else {
        emit(AuthErrorState(response.data['message'] ?? "فشل تسجيل الحساب"));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  void login(LoginRequestModel model) async {
    emit(AuthLoadingState());
    try {
      final response = await _dataSource.login(model);
      if (response.statusCode == 200) {
        emit(AuthSuccessState("تم تسجيل الدخول بنجاح! 👋"));
      } else {
        emit(AuthErrorState(response.data['message'] ?? "فشل تسجيل الدخول"));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}