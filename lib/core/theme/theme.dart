import 'package:flutter/material.dart';
import 'package:flutter_music_player/core/theme/colors.dart';
import 'package:flutter_music_player/core/utils/locale_handler.dart';

class AppTheme {
  AppTheme(
    this.context,
    final Color primaryColor,
    final Color lightPrimaryColor,
  ) {
    lightTheme = ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        background: Colors.white,
      ),
      navigationBarTheme: NavigationBarThemeData(
        iconTheme: MaterialStateProperty.resolveWith(
          (final Set<MaterialState> state) {
            if (state.contains(MaterialState.selected)) {
              return IconThemeData(color: AppColors.white);
            }
            return IconThemeData(color: primaryColor);
          },
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        selectedIconTheme: IconThemeData(
          color: AppColors.white,
        ),
      ),
      textTheme: Typography().black.apply(
            fontFamily:
                checkEnState(context) ? 'IranYekanX' : 'IranYekanXFaNum',
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        toolbarTextStyle: TextStyle(
          fontFamily: checkEnState(context) ? 'IranYekanX' : 'IranYekanXFaNum',
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: lightPrimaryColor,
        brightness: Brightness.dark,
      ),
      navigationRailTheme: NavigationRailThemeData(
        selectedIconTheme: IconThemeData(
          color: AppColors.white,
        ),
      ),
      textTheme: Typography().white.apply(
            fontFamily:
                checkEnState(context) ? 'IranYekanX' : 'IranYekanXFaNum',
          ),
      appBarTheme: AppBarTheme(
        toolbarTextStyle: TextStyle(
          fontFamily: checkEnState(context) ? 'IranYekanX' : 'IranYekanXFaNum',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  BuildContext context;
  late ThemeData lightTheme;
  late ThemeData darkTheme;
}
