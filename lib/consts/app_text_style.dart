import 'package:flutter/material.dart';
import 'package:picture_app/consts/app_colors.dart';

class AppStyles {
  static const TextStyle tabBarTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'SF',
  );

  static const TextStyle nameTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    color: AppColor.nameColor,
  );

  static const TextStyle userTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFamily: 'SF',
    color: AppColor.indicatorColor,
  );

  static const TextStyle descriptionTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    color: AppColor.descriptionColor,
  );

  static const TextStyle dateTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    color: AppColor.greyColor,
  );

  static const TextStyle viewsTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'SF',
    color: AppColor.black,
  );

  static const TextStyle countViewsTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'SF',
    color: AppColor.greyColor,
  );

  static const TextStyle errorMessageTextStyle = TextStyle(
    color: AppColor.black,
    fontSize: 12.0,
    height: 2.0,
  );

  static const TextStyle errorTitleTextStyle = TextStyle(
    color: AppColor.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
}
