import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(7, 143, 255, .1),
  100: const Color.fromRGBO(7, 143, 255, .2),
  200: const Color.fromRGBO(7, 143, 255, .3),
  300: const Color.fromRGBO(7, 143, 255, .4),
  400: const Color.fromRGBO(7, 143, 255, .5),
  500: const Color.fromRGBO(7, 143, 255, .6),
  600: const Color.fromRGBO(7, 143, 255, .7),
  700: const Color.fromRGBO(7, 143, 255, .8),
  800: const Color.fromRGBO(7, 143, 255, .9),
  900: const Color.fromRGBO(7, 143, 255, 1),
};

MaterialColor mainColor = MaterialColor(0xFF078fff, color);

InputDecoration roundedInput(String label, String hintText,
        [double radius = 10]) =>
    InputDecoration(
      isDense: true,
      border: const OutlineInputBorder(),
      enabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainColor, width: 1),
        borderRadius: BorderRadius.circular(radius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(radius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainColor, width: 1),
        borderRadius: BorderRadius.circular(radius),
      ),
      labelText: label,
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
    );

InputDecoration underlineInput(String label, String hintText) =>
    InputDecoration(
      isDense: true,
      border: const UnderlineInputBorder(),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      labelText: label,
      hintText: hintText,
    );
