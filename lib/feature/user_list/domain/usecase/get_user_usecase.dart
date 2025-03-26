import 'package:codebase_project_assignment/core/errors/failure.dart';
import 'package:codebase_project_assignment/core/usecases/usecase.dart';
import 'package:codebase_project_assignment/feature/user_list/domain/entity/user_entity.dart';
import 'package:codebase_project_assignment/feature/user_list/domain/repository/user_repo.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase extends UseCase<List<UserDataEntity>, GetUserParams> {
  final UserRepo userRepo;

  GetUserUsecase({required this.userRepo});
  @override
  Future<Either<Failure, List<UserDataEntity>>> call(
      GetUserParams params) async {
    return await userRepo.getUsers(pageNumber: params.pageNumber);
  }
}

class GetUserParams extends Params {
  final String pageNumber;

  GetUserParams({required this.pageNumber});

  @override
  List<Object?> get props => [pageNumber];
}
