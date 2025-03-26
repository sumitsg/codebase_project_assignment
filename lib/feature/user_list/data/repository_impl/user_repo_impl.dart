import 'package:codebase_project_assignment/core/errors/failure.dart';
import 'package:codebase_project_assignment/feature/user_list/data/datasource/user_list_datasource.dart';
import 'package:codebase_project_assignment/feature/user_list/data/model/user_list_model.dart';
import 'package:codebase_project_assignment/feature/user_list/domain/repository/user_repo.dart';
import 'package:dartz/dartz.dart';

class UserRepoImpl extends UserRepo {
  final UserListDatasource userListDatasource;

  UserRepoImpl({required this.userListDatasource});
  @override
  Future<Either<Failure, List<UserData>>> getUsers(
      {required String pageNumber}) async {
    try {
      final users = await userListDatasource.getUsers(pageNumber: pageNumber);
      return right(users);
    } on ServerFailure catch (e) {
      return left(ServerFailure(message: e.message));
    } on CacheFailure {
      return left(CacheFailure());
    } on NetworkFailure {
      return left(NetworkFailure());
    } on InvalidInputFailure catch (e) {
      return left(InvalidInputFailure(message: e.message));
    }
  }
}
