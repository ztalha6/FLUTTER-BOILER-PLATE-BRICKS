import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../configuration.dart';

class AppTheme {
  Configuration configs = Configuration();
  ThemeData getAppTheme(BuildContext context) => ThemeData(
        iconTheme: const IconThemeData(color: Colors.black),
        dividerColor: Colors.black,
        appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: const IconThemeData(color: Colors.black),
          toolbarHeight: 8.h,
          titleTextStyle:
              Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
          // toolbarTextStyle: GoogleFonts.inter(
          //   fontSize: 10,
          //   color: Theme.of(context).primaryColor,
          //   fontWeight: FontWeight.normal,
          // ),
          elevation: 0,
          actionsIconTheme: const IconThemeData(color: Colors.black),
        ),
        brightness: Brightness.light,
        primaryColor: configs.primaryColor,
        disabledColor: const Color(0xffADAFB2),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            textStyle: MaterialStateProperty.all<TextStyle>(
              GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(
              Size(double.infinity, 60.h),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: configs.secondaryColor,
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  // return null;
                }
                return Theme.of(context).primaryColor;
              },
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                (Set<MaterialState> states) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              );
            }),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color.fromRGBO(139, 198, 182, 1),
            side: BorderSide(
              width: 1.0.w,
              color: const Color.fromRGBO(139, 198, 182, 1),
            ),
          ),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          titleMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          displayMedium: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleSmall: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: const Color(0xffADAFB2),
          ),
          displaySmall: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          headlineMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xff646C7C),
          ),
          bodyLarge: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black54,
          ),
          titleLarge: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      );
}
