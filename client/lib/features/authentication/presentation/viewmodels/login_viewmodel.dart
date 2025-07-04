import 'package:oneoone_library/features/authentication/data/datasources/authentication_remort_data_source_impl.dart';
import 'package:oneoone_library/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/states/login_state.dart';
import '../../domain/repositories/authentication_repository.dart';

part 'login_viewmodel.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  final AuthenticationRepository _authenticationRepositoryImpl =
      AuthenticationRepositoryImpl(AuthenticationRemoteDataSourceImpl());

  @override
  Future<LoginState> build() async {
    return LoginState();
  }

  Future<void> login() async {
    try {
      state = const AsyncLoading();
      String accessToken = await _authenticationRepositoryImpl.login();
      state = AsyncData(LoginState(accessToken: accessToken, isSuccess: true));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
    ;
  }
}
