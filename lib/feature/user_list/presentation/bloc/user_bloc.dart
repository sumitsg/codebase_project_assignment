import 'package:codebase_project_assignment/feature/user_list/domain/entity/user_entity.dart';
import 'package:codebase_project_assignment/feature/user_list/domain/usecase/get_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUsecase getUserUsecase;
  bool isFetchingMore = false;

  List<UserDataEntity> usersList = [];
  List<UserDataEntity> filteredUsersList = [];
  UserBloc({required this.getUserUsecase}) : super(UserInitial()) {
    on<UserEvent>((event, emit) {});

    on<GetUserListEvent>((event, emit) async {
      if (isFetchingMore) return;

      isFetchingMore = (int.tryParse(event.pageNumber)! > 1)
          ? true
          : false; // Set loading only for pagination requests

      if (event.pageNumber == '1') {
        emit(UserDataLoadingState());
      } else {
        emit(UserDataSuccessState(
          userDataList: event.currentUsersList,
          isPaginating: isFetchingMore,
          time: DateTime.now().millisecondsSinceEpoch,
        ));
      }

      // calling the user case for API calling
      final result = await getUserUsecase
          .call(GetUserParams(pageNumber: event.pageNumber));

      // checking the result
      result.fold((failure) {
        //
        isFetchingMore = false;
        emit(UserDataFailureState());
      }, (users) {
        // setting as all users list with old users list
        // debugPrint(
        //     "list length ${event.currentUsersList.length} --> ${users.length}");

        List<UserDataEntity> cobinedUserList = [
          ...event.currentUsersList,
          ...users
        ];
        List<UserDataEntity> allUsers = List.from(cobinedUserList.toSet());
        // allUsers.addAll(users);

        usersList.clear();
        usersList.addAll(allUsers);

        //
        isFetchingMore = false;
        emit(UserDataSuccessState(
            userDataList: allUsers,
            isPaginating: isFetchingMore,
            time: DateTime.now().millisecondsSinceEpoch));
      });
    });

    on<SearchUserListEvent>((event, emit) {
      if (event.query.isEmpty) {
        emit(UserDataSuccessState(
          userDataList: usersList,
          isPaginating: false,
          time: DateTime.now().millisecondsSinceEpoch,
        ));
        return;
      } else {
        filteredUsersList = usersList
            .where((element) =>
                element.firstName!
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                element.lastName!
                    .toLowerCase()
                    .contains(event.query.toLowerCase()))
            .toList();
        emit(UserDataSuccessState(
          userDataList: filteredUsersList,
          isPaginating: false,
          time: DateTime.now().millisecondsSinceEpoch,
        ));
      }
    });
  }
}
