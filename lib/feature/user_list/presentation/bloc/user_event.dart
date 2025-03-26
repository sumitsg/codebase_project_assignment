part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserListEvent extends UserEvent {
  final String pageNumber;
  final List<UserDataEntity> currentUsersList;

  GetUserListEvent(
      {required this.pageNumber, this.currentUsersList = const []});

  @override
  List<Object?> get props => [pageNumber, currentUsersList];
}

class SearchUserListEvent extends UserEvent {
  final String query;

  SearchUserListEvent({required this.query});
  // final List<UserDataEntity> currentUsersList;

  @override
  List<Object?> get props => [query];
}
