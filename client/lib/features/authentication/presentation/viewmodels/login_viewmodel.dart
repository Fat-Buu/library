import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    final storage = FlutterSecureStorage();
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      String accessToken = await _authenticationRepositoryImpl.login();
      storage.write(key: "access_token", value: accessToken);
      return LoginState(accessToken: accessToken);
    });
  }

  Future<void> loginWithGuest() async {
    final storage = FlutterSecureStorage();
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      String accessToken = "guest_access_token";
      storage.write(key: "access_token", value: accessToken);
      return LoginState(accessToken: accessToken);
    });
  }

  Future<void> logout() async {
    final storage = FlutterSecureStorage();
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await storage.delete(key: "access_token");
      return LoginState(accessToken: "");
    });
  }
}
