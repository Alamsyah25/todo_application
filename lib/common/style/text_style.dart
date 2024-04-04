import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleTheme {
  static TextStyleTheme? _current;

  static TextStyleTheme get current => _current!;

  static TextStyleTheme init() {
    return _current ??= TextStyleTheme();
  }

  TextStyle get headline1Heavy {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.bold,
        fontSize: 96.sp,
        height: 1.25,
      ),
    );
  }

  TextStyle get headline1Light {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.normal,
        fontSize: 96.sp,
        height: 1.25,
      ),
    );
  }

  TextStyle get headline2Heavy {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.bold,
        fontSize: 64.sp,
        height: 1.25,
      ),
    );
  }

  TextStyle get headline2Light {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.normal,
        fontSize: 64.sp,
        height: 1.25,
      ),
    );
  }

  TextStyle get headline3Heavy {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.bold,
        fontSize: 48.sp,
        height: 1.16,
      ),
    );
  }

  TextStyle get headline3Light {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.normal,
        fontSize: 48.sp,
        height: 1.16,
      ),
    );
  }

  TextStyle get headline4Heavy {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.bold,
        fontSize: 32.sp,
        height: 1.25,
      ),
    );
  }

  TextStyle get headline4Light {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.normal,
        fontSize: 32.sp,
        height: 1.25,
      ),
    );
  }

  TextStyle get subHeading1Heavy {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.w900,
        fontSize: 24.sp,
        height: 1.33,
      ),
    );
  }

  TextStyle get subHeading1Light {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.w500,
        fontSize: 24.sp,
        height: 1.33,
      ),
    );
  }

  TextStyle get subHeading2Heavy {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.w900,
        fontSize: 20.sp,
        height: 1.4,
      ),
    );
  }

  TextStyle get subHeading2Light {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.w500,
        fontSize: 20.sp,
        height: 1.4,
      ),
    );
  }

  TextStyle get subHeading3Heavy {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.w900,
        fontSize: 18.sp,
        height: 1.44,
      ),
    );
  }

  TextStyle get subHeading3Light {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
        height: 1.44,
      ),
    );
  }

  TextStyle get bodyText1Heavy {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
        height: 1.5,
      ),
    );
  }

  TextStyle get bodyText1Light {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.normal,
        fontSize: 16.sp,
        height: 1.5,
      ),
    );
  }

  TextStyle get bodyText2Heavy {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
        height: 1.57,
      ),
    );
  }

  TextStyle get bodyText2Light {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.normal,
        fontSize: 14.sp,
        height: 1.57,
      ),
    );
  }

  TextStyle get bodyText3Heavy {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
        height: 1.5,
        letterSpacing: 0.25,
      ),
    );
  }

  TextStyle get bodyText3Light {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.normal,
        fontSize: 12.sp,
        height: 1.5,
        letterSpacing: 0.25,
      ),
    );
  }

  TextStyle get bodyText4Heavy {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.bold,
        fontSize: 10.sp,
        height: 1.6,
        letterSpacing: 0.5,
      ),
    );
  }

  TextStyle get bodyText4Light {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        leadingDistribution: TextLeadingDistribution.even,
        fontWeight: FontWeight.w500,
        fontSize: 10.sp,
        height: 1.6,
        letterSpacing: 0.5,
      ),
    );
  }
}
