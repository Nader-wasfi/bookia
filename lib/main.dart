import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/use_cases/login_use_case.dart';
import 'features/auth/domain/use_cases/register_use_case.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/views/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRemoteDataSource = AuthRemoteDataSource();
    final authRepository = AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
    final loginUseCase = LoginUseCase(repository: authRepository);
    final registerUseCase = RegisterUseCase(repository: authRepository);

    return BlocProvider(
      create: (context) => AuthCubit(
        loginUseCase: loginUseCase,
        registerUseCase: registerUseCase,
      ),
      child: MaterialApp(
        title: 'Bookia App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFFBB9967),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: LoginView(),
      ),
    );
  }
}