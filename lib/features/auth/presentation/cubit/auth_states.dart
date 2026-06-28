abstract class AuthStates {}

class AuthInitialState extends AuthStates {}
class AuthLoadingState extends AuthStates {}
class AuthSuccessState extends AuthStates {
  final String message;
  AuthSuccessState(this.message);
}
class AuthErrorState extends AuthStates {
  final String errorMessage;
  AuthErrorState(this.errorMessage);
}