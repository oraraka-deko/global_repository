import 'dart:ui';

const int _opacity10 = 25;
const int _opacity15 = 38;
const int _opacity20 = 51;
const int _opacity40 = 102;
const int _opacity60 = 153;
const int _opacity80 = 204;

extension ColorExtension on Color {
  Color get opacity10 {
    return withAlpha(_opacity10);
  }

  Color get opacity15 {
    return withAlpha(_opacity15);
  }

  Color get opacity20 {
    return withAlpha(_opacity20);
  }

  Color get opacity40 {
    return withAlpha(_opacity40);
  }

  Color get opacity60 {
    return withAlpha(_opacity60);
  }

  Color get opacity80 {
    return withAlpha(_opacity80);
  }
}
