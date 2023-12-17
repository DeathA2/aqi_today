class ScreenSizeUtils {
  static const _screenHeightThreshHold = 700;
  static bool isShortScreen(double height) {
    return height < _screenHeightThreshHold;
  }
}
