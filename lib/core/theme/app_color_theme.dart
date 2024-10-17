import 'package:flutter/material.dart';

class AppColorTheme extends ThemeExtension<AppColorTheme> {
  final Color textMeidum;
  final Color textBottom;
  final Color colorBox;
  final Color textSmall;
  final Color background;

  AppColorTheme(
      {required this.textMeidum,
      required this.textBottom,
      required this.colorBox,
      required this.textSmall,
      required this.background});

  @override
  AppColorTheme copyWith(
      {Color? textColor,
      Color? textColorBottom,
      Color? colorBox,
      Color? textSmall,
      Color? background}) {
    return AppColorTheme(
        textMeidum: textColor ?? this.textMeidum,
        textBottom: textColorBottom ?? this.textBottom,
        colorBox: colorBox ?? this.colorBox,
        textSmall: textSmall ?? this.textSmall,
        background: background ?? this.background);
  }

  @override
  AppColorTheme lerp(covariant ThemeExtension<AppColorTheme>? other, double t) {
    if (other is! AppColorTheme) {
      return this;
    }
    return AppColorTheme(
        textMeidum: Color.lerp(textMeidum, other.textMeidum, t)!,
        textBottom: Color.lerp(textBottom, other.textBottom, t)!,
        colorBox: Color.lerp(colorBox, other.colorBox, t)!,
        textSmall: Color.lerp(textSmall, other.textSmall, t)!,
        background: Color.lerp(background, other.background, t)!);
  }

  static AppColorTheme of(BuildContext context) {
    return Theme.of(context).extension<AppColorTheme>()!;
  }
}
