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
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      String accessToken = await _authenticationRepositoryImpl.login();
      return LoginState(accessToken: accessToken, isSuccess: true);
    });
  }
}
