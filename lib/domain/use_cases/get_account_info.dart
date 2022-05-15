
import 'package:store_app/domain/entities/account_info_entity.dart';
import 'package:store_app/domain/repositories/users_repository.dart';

class GetAccountInfoUseCase {
  final UsersRepository repository;
  GetAccountInfoUseCase({required this.repository});

  Future<AccountInfoEntity?> call() async {
    return repository.accountInfo();
  }
}