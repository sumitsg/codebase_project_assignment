import 'package:codebase_project_assignment/core/bloc/connectivity_bloc.dart';
import 'package:codebase_project_assignment/core/platform/network_info.dart';
import 'package:codebase_project_assignment/feature/user_list/data/datasource/user_list_datasource.dart';
import 'package:codebase_project_assignment/feature/user_list/data/repository_impl/user_repo_impl.dart';
import 'package:codebase_project_assignment/feature/user_list/domain/repository/user_repo.dart';
import 'package:codebase_project_assignment/feature/user_list/domain/usecase/get_user_usecase.dart';
import 'package:codebase_project_assignment/feature/user_list/presentation/bloc/user_bloc.dart';
import 'package:codebase_project_assignment/local_data/hive_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Register HTTP Client
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<HiveService>(() => HiveService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  /// Bloc
  sl.registerLazySingleton(() => UserBloc(getUserUsecase: sl()));
  sl.registerLazySingleton(
      () => ConnectivityBloc(networkInfo: sl())..add(CheckConnectivity()));

  /// use cases
  sl.registerLazySingleton<GetUserUsecase>(
      () => GetUserUsecase(userRepo: sl()));

  /// repositories
  sl.registerLazySingleton<UserRepo>(
      () => UserRepoImpl(userListDatasource: sl()));

  /// remote datasource
  sl.registerLazySingleton<UserListDatasource>(() => UserListDatasourceImpl(
        client: sl(),
        hiveService: sl(),
        networkInfo: sl(),
      ));
}
