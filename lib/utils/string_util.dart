
class StringUtil {
  /// 字符串是否为空
  static bool isEmpty(String text) {
    if (text == null) {
      return true;
    }

    return text.length == 0;
  }

  /// 字符串是否不为空
  static bool isNotEmpty(String text) {
    return !isEmpty(text);
  }

  static String durationFormat(int duration) {
    var minute = duration ~/ 60;
    var second = duration % 60;
    if (minute <= 9) {
      if (second <= 9) {
        return "0$minute' 0$second''";
      } else {
        return "0$minute' $second''";
      }
    } else {
      if (second <= 9) {
        return "$minute' 0$second''";
      } else {
        return "$minute' $second''";
      }
    }
  }

  static String dataFormat(int total) {
    String result;
    int speedReal = total ~/ 1024;
    if (speedReal < 512) {
      result = speedReal.toString() + " KB";
    } else {
      double mSpeed = speedReal / 1024;
      result = (mSpeed * 100 / 100.0).toStringAsFixed(0) + " MB";
    }
    return result;
  }
}
