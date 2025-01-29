import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = ThemeData(
  primaryColor: ElevarmColors.primary,
  colorScheme: const ColorScheme.light(
    primary: ElevarmColors.primary,
    secondary: ElevarmColors.success,
  ),
  scaffoldBackgroundColor: ElevarmColors.neutral25,
  dividerTheme: const DividerThemeData(
    color: ElevarmColors.neutral50,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: ElevarmColors.white,
    surfaceTintColor: Colors.transparent,
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.transparent,
  ),
  popupMenuTheme: const PopupMenuThemeData(
    surfaceTintColor: Colors.transparent,
  ),
  textTheme: GoogleFonts.robotoTextTheme(),
  useMaterial3: false,
);
