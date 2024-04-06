import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_application/common/constants/colors.dart';
import 'package:todo_application/common/style/text_style.dart';

ThemeData get themeApp => ThemeData.light(useMaterial3: true).copyWith(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: kNeutral0,
      appBarTheme: AppBarTheme(
        color: kPrimary,
        toolbarTextStyle: TextStyleTheme.current.bodyText2Light.copyWith(
          color: kPrimary,
        ),
        actionsIconTheme: const IconThemeData(color: kPrimary),
        iconTheme: ThemeData.dark().iconTheme.copyWith(color: kNeutral0),
        titleTextStyle: TextStyleTheme.current.bodyText1Light.copyWith(
          color: kNeutral0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyleTheme.current.bodyText2Light.copyWith(
            color: kNeutral900,
            height: 1.w,
          ),
          hintStyle: TextStyleTheme.current.bodyText2Light.copyWith(
            color: kNeutral900,
          ),
          floatingLabelStyle: TextStyleTheme.current.bodyText2Light.copyWith(
            color: kPrimary,
            height: 1.w,
          ),
          helperStyle: TextStyleTheme.current.bodyText3Light.copyWith(
            color: kNeutral600,
          ),
          errorStyle: TextStyleTheme.current.bodyText3Light.copyWith(
            color: kError,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kError,
              width: 2.w,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(4.r),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kNeutral600,
              width: 1.w,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(4.r),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kPrimary,
              width: 1.5.w,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(4.r),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kError,
              width: 2.w,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(4.r),
            ),
          )),
      typography: Typography.material2018(),
    );
