import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:magic/src/app/router.dart';
import 'package:magic/src/core/core.dart';
import 'package:magic/src/cubit/theme/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int theme = 0;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 850),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Magic App',
            //debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: materialColor,
              brightness: getTheme(theme),
              fontFamily: TextStyles.poppins.fontFamily,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: AppTheme.of(context).primary,
              ),
              scaffoldBackgroundColor: AppTheme.theme(getTheme(theme)).bg1,
            ),
            darkTheme: ThemeData(
              primarySwatch: materialColor,
              brightness: getTheme(theme),
              fontFamily: TextStyles.poppins.fontFamily,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: getTheme(theme) == Brightness.dark
                    ? Colors.black
                    : Colors.white,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: AppTheme.of(context).primary,
              ),
              scaffoldBackgroundColor: getTheme(theme) == Brightness.dark
                  ? null
                  : AppTheme.theme(getTheme(theme)).bg1,
              // scaffoldBackgroundColor: Colors.black,
            ),
            themeMode: ThemeMode.system,
            builder: (context, widget) {
              return ResponsiveWrapper.builder(
                ClampingScrollWrapper.builder(context, widget!),
                defaultScale: true,
                minWidth: 480,
                defaultName: MOBILE,
                breakpoints: const [
                  ResponsiveBreakpoint.resize(
                    480,
                    name: MOBILE,
                  ),
                  ResponsiveBreakpoint.resize(
                    750,
                    name: TABLET,
                  ),
                  ResponsiveBreakpoint.resize(
                    1000,
                    name: DESKTOP,
                  ),
                ],
                background: Container(
                  color: AppTheme.theme(getTheme(theme)).bg1,
                ),
              );
            },
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          );
        },
      ),
      builder: (context, child) {
        return child!;
      },
    );

    // return BlocBuilder<ThemeCubit, ThemeState>(
    //   builder: (BuildContext context, ThemeState state) {
    //     if (state is ThemeLoaded) {
    //       return MaterialApp(
    //         builder: (context, widget) {
    //           return ResponsiveWrapper.builder(
    //             ClampingScrollWrapper.builder(context, widget!),
    //             defaultScale: false,
    //             minWidth: 480,
    //             defaultName: MOBILE,
    //             breakpoints: [
    //               const ResponsiveBreakpoint.resize(480, name: MOBILE),
    //               const ResponsiveBreakpoint.resize(750, name: TABLET),
    //               const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
    //             ],
    //             background: Container(color: const Color(0xFFF5F5F5)),
    //           );
    //         },
    //         title: 'Slam App, Swipe your way',
    //         debugShowCheckedModeBanner: false,
    //         theme: ThemeData(
    //           // brightness: Brightness.dark,
    //           bottomAppBarColor: Colors.black,
    //           brightness: state.theme == 0 ? Brightness.light : Brightness.dark,
    //           fontFamily: GoogleFonts.quicksand().fontFamily, //"Montserrat",
    //           primarySwatch: Colors.red,
    //           scaffoldBackgroundColor:
    //               state.theme == 0 ? const Color(0xFFF5F5F5) : null,
    //           appBarTheme: AppBarTheme(
    //             color: Colors.black,
    //             // brightness:
    //             //     state.theme != 0 ? Brightness.light : Brightness.dark,
    //             iconTheme: const IconThemeData(
    //               color: Colors.white54,
    //             ),
    //             toolbarTextStyle: Theme.of(context)
    //                 .primaryTextTheme
    //                 .copyWith(
    //                   headline6: Theme.of(context)
    //                       .textTheme
    //                       .headline6!
    //                       .copyWith(color: Colors.white),
    //                 )
    //                 .bodyText2,
    //             titleTextStyle: Theme.of(context)
    //                 .primaryTextTheme
    //                 .copyWith(
    //                   headline6: Theme.of(context)
    //                       .textTheme
    //                       .headline6!
    //                       .copyWith(color: Colors.white),
    //                 )
    //                 .headline6,
    //           ),
    //         ),
    //         onGenerateRoute: AppRouter.generateRoute,
    //       );
    //     }
    //     return Container();
    //   },
    // );
  }

  Brightness getTheme(int value) {
    if (value == 0) {
      return Brightness.light;
    } else if (value == 1) {
      return Brightness.dark;
    } else {
      return Brightness.light;
    }
  }
}
