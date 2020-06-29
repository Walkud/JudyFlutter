import 'dart:ui';

class ColorUtil {


  ///计算两个颜色的过渡色
  ///startColor 示例：0xffffffff
  ///endColor 示例：0xff000000
  static Color caculateColorInt(int startColor, int endColor, double franch) {
    return caculateColor(Color(startColor), Color(endColor), franch);
  }

  ///计算两个颜色的过渡色
  static Color caculateColor(Color startColor, Color endColor, double franch){
    int startAlpha = startColor.alpha;
    int startRed = startColor.red;
    int startGreen = startColor.green;
    int startBlue = startColor.blue;

    int endAlpha = endColor.alpha;
    int endRed = endColor.red;
    int endGreen = endColor.green;
    int endBlue = endColor.blue;

    int alpha = ((endAlpha - startAlpha) * franch + startAlpha).toInt();
    int red = ((endRed - startRed) * franch + startRed).toInt();
    int green = ((endGreen - startGreen) * franch + startGreen).toInt();
    int blue = ((endBlue - startBlue) * franch + startBlue).toInt();

    return Color.fromARGB(alpha, red, green, blue);

  }
}
