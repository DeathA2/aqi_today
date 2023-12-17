class ImageApp {
  static String logoYSinh = ImagesPath.getPath('logo_khoa.png');
  static String bodyMan = ImagesPath.getPath('body.png');
  static String map = ImagesPath.getPath('map.png');
  static String icName = ImagesPath.getPath('ic_name.png');
  static String icDevice = ImagesPath.getPath('ic_device.png');
  static String icOlderMan = ImagesPath.getPath('ic_older_man.png');
  static String icOlderWoman = ImagesPath.getPath('ic_older_woman.png');

  static String heartRateLottie = ImagesPath.getPath('heart_lottie.json');
  static String spO2Lottie = ImagesPath.getPath('lungs.json');

  static String icFemale = ImagesPath.getPath('ic_female.svg');
  static String icMale = ImagesPath.getPath('ic_male.svg');
  static String warning = ImagesPath.getPath('warning.svg');

  // ===============================================
  static String logoApp = ImagesPath.getPath('logo.png');
  static String hcmBg = ImagesPath.getPath('hcm_bg.jpg');
  static String airQuality = ImagesPath.getPath('aQI_lottie.json');
}

extension ImagesPath on ImageApp {
  static String getPath(String name) {
    if (name.contains('.svg')) {
      return 'assets/svg/$name';
    }
    if (name.contains('.png')) {
      return 'assets/imgs/$name';
    }
    if (name.contains('.json')) {
      return 'jsons/$name';
    }
    return 'assets/imgs/$name';
  }
}
