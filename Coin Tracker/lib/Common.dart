class Common{

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    }
    else {
      return value+.0;
    }
  }

}
