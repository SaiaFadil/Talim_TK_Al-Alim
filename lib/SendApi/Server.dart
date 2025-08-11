class Server {
  static const String ROUTE = "http://192.169.1.2:8000/";

  static Uri urlLaravel(String url) {
    return Uri.parse("${ROUTE}mobile/$url");
  }

  static String UrlImageGreenhouse(String url) {
    return "${ROUTE}img/green_house/$url";
  }

  static String UrlImageProfil(String url) {
    return "${ROUTE}img/user/$url";
  }

  static String urlGambar(String url) {
    return "assets/images/$url";
  }
}
