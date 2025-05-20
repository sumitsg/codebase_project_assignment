import 'dart:convert';

import 'package:codebase_project_assignment/core/platform/network_info.dart';
import 'package:codebase_project_assignment/feature/user_list/data/model/user_list_model.dart';
import 'package:codebase_project_assignment/local_data/hive_service.dart';
import 'package:codebase_project_assignment/utils/constants/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

abstract class UserListDatasource {
  Future<List<UserData>> getUsers({required String pageNumber});
}

class UserListDatasourceImpl extends UserListDatasource {
  final http.Client client;
  final HiveService hiveService;
  final NetworkInfo networkInfo;

  UserListDatasourceImpl(
      {required this.client,
      required this.hiveService,
      required this.networkInfo});
  @override
  Future<List<UserData>> getUsers({required String pageNumber}) async {
    List<UserData> users = [];

    // actual API calls

    // if no internet connection, fetch from cache
    if (!await networkInfo.isConnected) {
      Fluttertoast.showToast(
        msg: "No Internet Connection Available..\nShowing offline data",
        backgroundColor: Colors.black,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
        toastLength: Toast.LENGTH_LONG,
      );

      List<UserData> cachedUsers = await hiveService.getUsers() ?? [];

      //  Prevent duplicate data
      users = List<UserData>.from(cachedUsers.toSet());

      return users;
    } else {
      try {
        final response = await client.get(
          Uri.parse(ApiUrls.getUsersList(10, int.parse(pageNumber))),
          headers: {"x-api-key": "reqres-free-v1"},
        );

        if (ApiUrls.isSuccessful(response.statusCode)) {
          final userListModel =
              UserListModel.fromJson(jsonDecode(response.body));
          users = userListModel.data?.map((e) => e).toList() ?? [];
          await hiveService.saveUsers(users);
        }
        // Save to Hive cache
        return users;
      } catch (e) {
        print("Fetching from cache due to error: $e");

        // Fetch cached data if API fails
        users = await hiveService.getUsers() ?? [];

        return users;
      }
    }
  }
}
