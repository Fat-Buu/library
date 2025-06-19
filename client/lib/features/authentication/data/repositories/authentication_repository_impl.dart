import 'package:oneoone_library/features/authentication/domain/repositories/authentication_repository.dart';

import '../datasources/authentication_remort_data_source_impl.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRemoteDataSourceImpl authenticationRemoteDataSourceImpl;

  AuthenticationRepositoryImpl(this.authenticationRemoteDataSourceImpl);

  @override
  Future<String> login() async {
    return authenticationRemoteDataSourceImpl.authentication();
  }
}
