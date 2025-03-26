import 'package:cached_network_image/cached_network_image.dart';
import 'package:codebase_project_assignment/feature/user_list/domain/entity/user_entity.dart';
import 'package:codebase_project_assignment/utils/constants/app_textstyle.dart';
import 'package:codebase_project_assignment/utils/constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetailedPage extends StatefulWidget {
  final UserDataEntity userInformation;
  static const routeName = "/user_detailed_page";
  const UserDetailedPage({super.key, required this.userInformation});

  @override
  State<UserDetailedPage> createState() => _UserDetailedPageState();
}

class _UserDetailedPageState extends State<UserDetailedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 198, 223, 248),
      backgroundColor: CustomColors.blueFE,
      appBar: AppBar(
          title: const Text("User Detailed Page"),
          backgroundColor: CustomColors.blueFA),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Container(
              width: double.maxFinite,
              height: 250,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 220, 231, 244),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      widget.userInformation.avatar ?? ""),
                  fit: BoxFit.contain,
                ),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100)),
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 10.ms)
              .scaleXY(begin: 0.0, end: 1, duration: 800.ms),

          //
          34.verticalSpace,

          //
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Information",
                  style: AppTextStyles.font18w500TextStyle(),
                ),
                14.verticalSpace,
                Text(
                  "Name: ${widget.userInformation.firstName ?? ""} ${widget.userInformation.lastName ?? ""}",
                  style: AppTextStyles.font16w500TextStyle(),
                ),
                Text(
                  "Email: ${widget.userInformation.email ?? ""}",
                  style: AppTextStyles.font12w400TextStyle(),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.3, end: 0.0, duration: 500.ms),
          )
        ],
      ),
    );
  }
}
