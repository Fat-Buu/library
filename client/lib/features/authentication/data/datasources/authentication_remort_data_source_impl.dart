import 'package:oneoone_library/features/authentication/data/datasources/authentication_remort_data_source.dart';

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  @override
  Future<String> authentication() async {
    await Future.delayed(Duration(seconds: 3));
    return "asd012312e1md120d012d12dm";
  }
}
