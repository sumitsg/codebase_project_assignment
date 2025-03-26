import 'package:cached_network_image/cached_network_image.dart';
import 'package:codebase_project_assignment/core/bloc/connectivity_bloc.dart';
import 'package:codebase_project_assignment/feature/user_list/domain/entity/user_entity.dart';
import 'package:codebase_project_assignment/feature/user_list/presentation/bloc/user_bloc.dart';
import 'package:codebase_project_assignment/feature/user_list/presentation/screens/user_detailed_page.dart';
import 'package:codebase_project_assignment/utils/constants/app_textstyle.dart';
import 'package:codebase_project_assignment/utils/constants/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserListingScreen extends StatefulWidget {
  static const String routeName = "/user_listing_screen";
  const UserListingScreen({super.key});

  @override
  State<UserListingScreen> createState() => _UserListingScreenState();
}

class _UserListingScreenState extends State<UserListingScreen> {
  //
  late UserBloc _userBloc;
  late ConnectivityBloc _connectivityBloc;

  //
  int _currentPage = 1;

  // for pagination
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

// Search controller
  final TextEditingController searchController = TextEditingController();

  // DI instance
  final getIt = GetIt.instance;
  @override
  void initState() {
    super.initState();

    _userBloc = getIt<UserBloc>();
    _connectivityBloc = getIt<ConnectivityBloc>();

    //calling the user list api for first time
    defaultApiCalls();
    // checkInternetAndFetchUsers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              (_scrollController.position.maxScrollExtent) &&
          (!_userBloc.isFetchingMore)) {
        loadMoreUsers();
      }
    });
  }

  defaultApiCalls() {
    _currentPage = 1;
    _userBloc.add(GetUserListEvent(
      pageNumber: _currentPage.toString(),
      currentUsersList: const [],
    ));
  }

  void loadMoreUsers() {
    // _isFetchingMore = true;
    _currentPage++;
    debugPrint(
        "ScrollController: ${_scrollController.position.pixels} --> ${_scrollController.position.maxScrollExtent} --> $_currentPage");
    _userBloc.add(GetUserListEvent(
      pageNumber: _currentPage.toString(),
      currentUsersList: (_userBloc.state as UserDataSuccessState).userDataList,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Listing"),
        backgroundColor: CustomColors.blueFA,
        leading: const SizedBox.shrink(),
      ),
      backgroundColor: CustomColors.blueFE,
      body: BlocConsumer<ConnectivityBloc, ConnectivityState>(
        bloc: _connectivityBloc,
        listener: (context, state) {},
        builder: (context, connectivityState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search bar
                TextFormField(
                  controller: searchController,
                  onChanged: (query) =>
                      _userBloc.add(SearchUserListEvent(query: query)),
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.search, color: CustomColors.grey6e),
                      hintText: "Search user",
                      hintStyle: AppTextStyles.font12w400TextStyle()
                          .copyWith(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0.r),
                        borderSide: const BorderSide(
                            color: CustomColors.black, width: 10),
                      ),
                      filled: true,
                      fillColor: CustomColors.blueFA,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          searchController.clear();
                          _userBloc.add(SearchUserListEvent(query: ""));
                          FocusManager.instance.primaryFocus?.unfocus();

                          // Reset to full list instead of refresh
                        },
                      )),
                ),

                if (connectivityState is ConnectivityOffline)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      6.verticalSpace,
                      const Icon(
                        Icons.wifi_off_sharp, // ✅ Use a clean "No WiFi" icon
                        size: 30,
                        color: Colors.redAccent,
                      ),
                      Text(
                        "No Internet Connection",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "Please check your network settings.",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                16.verticalSpace,
                Expanded(
                  child: RefreshIndicator(
                    key: _refreshKey,
                    onRefresh: () async {
                      defaultApiCalls();
                      return;
                    },
                    child: BlocConsumer<UserBloc, UserState>(
                      bloc: _userBloc,
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is UserDataLoadingState) {
                          return const Center(
                              child: CupertinoActivityIndicator());
                        } else if (state is UserDataSuccessState) {
                          _refreshKey.currentState?.deactivate();
                          if (state.userDataList.isEmpty) {
                            return const Center(child: Text("No users found"));
                          }
                          return ListView.separated(
                            controller: _scrollController,
                            itemCount: state.isPaginating
                                ? state.userDataList.length + 1
                                : state.userDataList.length,
                            itemBuilder: (context, index) {
                              if (index == state.userDataList.length) {
                                return const Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 20),
                                  child: CupertinoActivityIndicator(),
                                ));
                              }
                              UserDataEntity user = state.userDataList[index];
                              return GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                        context,
                                        UserDetailedPage.routeName,
                                        arguments: user,
                                      ),
                                  child: userListTile(user));
                            },
                            separatorBuilder: (context, index) =>
                                12.verticalSpace,
                          )
                              .animate()
                              .fadeIn(duration: 500.ms)
                              .slideX(begin: 0.3, end: 0.0, duration: 500.ms);
                        } else if (state is UserDataFailureState) {
                          _refreshKey.currentState?.deactivate();
                          return const Center(
                              child: Text("Failed to fetch users"));
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget userListTile(UserDataEntity user) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 220, 231, 244),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          ClipOval(
            child: CircleAvatar(
              radius: 30.r,
              child: CachedNetworkImage(
                imageUrl: user.avatar ?? "",
                // width: 45.r,
                // height: 50.r,
                fit: BoxFit.cover,
                errorWidget: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            ),
          ),
          12.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${user.firstName ?? ""} ${user.lastName ?? ""}",
                style: AppTextStyles.font16w500TextStyle(),
              ),
              Text(
                user.email ?? "",
                style: AppTextStyles.font12w400TextStyle(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
