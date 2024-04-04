import 'package:flutter/material.dart';
import 'package:todo_application/common/constants/colors.dart';
import 'package:todo_application/common/style/text_style.dart';

ThemeData get themeApp => ThemeData.dark().copyWith(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: kNeutral0,
      appBarTheme: AppBarTheme(
        color: kPrimary1,
        toolbarTextStyle: TextStyleTheme.current.bodyText2Light.copyWith(
          color: kPrimary1,
        ),
        actionsIconTheme: const IconThemeData(color: kPrimary1),
        iconTheme: ThemeData.dark().iconTheme.copyWith(color: kNeutral0),
        titleTextStyle: TextStyleTheme.current.bodyText1Light.copyWith(
          color: kNeutral0,
        ),
      ),
      typography: Typography.material2018(),
    );
