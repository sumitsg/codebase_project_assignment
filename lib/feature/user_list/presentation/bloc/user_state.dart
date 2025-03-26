part of 'user_bloc.dart';

abstract class UserState extends Equatable {}

final class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserDataLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserDataSuccessState extends UserState {
  final List<UserDataEntity> userDataList;
  final int time;
  final bool isPaginating;
  UserDataSuccessState(
      {required this.userDataList,
      required this.time,
      this.isPaginating = false});
  @override
  List<Object?> get props => [userDataList, time, isPaginating];
}

final class UserDataFailureState extends UserState {
  @override
  List<Object?> get props => [];
}
