import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class BaseWidget extends StatelessWidget {
  final String initalRoute;
  BaseWidget(this.initalRoute);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetMaterialApp(
          translations: LocalizationService(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          initialRoute: initalRoute,
          getPages: AppPages.routes,
          theme: ThemeData(
            iconTheme: const IconThemeData(color: Colors.black),
            dividerColor: Colors.black,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              iconTheme: const IconThemeData(color: Colors.black),
              toolbarHeight: 8.h,
              titleTextStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Gotham',
                color: Colors.black,
              ),
              toolbarTextStyle: TextStyle(
                fontSize: 10.sp,
                fontFamily: 'Gotham',
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.normal,
              ),
              elevation: 0,
              actionsIconTheme: const IconThemeData(color: Colors.black),
            ),
            scaffoldBackgroundColor: const Color(0xffFAFAFA),
            // primarySwatch: Colors.blue,∏
            brightness: Brightness.light,
            primaryColor: const Color.fromRGBO(139, 198, 182, 1),

            fontFamily: 'Gotham',
            disabledColor: const Color(0xffADAFB2),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gotham',
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
                  TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
              primary: const Color.fromRGBO(139, 198, 182, 1),
              side: BorderSide(
                width: 1.0.w,
                color: Color.fromRGBO(139, 198, 182, 1),
              ),
            )),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 22.sp,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              subtitle1: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.normal,
                color: Theme.of(context).primaryColor,
              ),
              headline2: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              subtitle2: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w300,
                color: Color(0xffADAFB2),
              ),
              headline3: TextStyle(
                fontSize: 20.sp,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              headline4: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w400,
                color: Color(0xff656666),
              ),
              bodyText1: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              bodyText2: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
              headline6: TextStyle(
                fontSize: 10.sp,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
        ),
      );
    });
  }
}
