import 'package:codebase_project_assignment/core/errors/failure.dart';
import 'package:codebase_project_assignment/feature/user_list/data/model/user_list_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepo {
  Future<Either<Failure, List<UserData>>> getUsers(
      {required String pageNumber});
}
