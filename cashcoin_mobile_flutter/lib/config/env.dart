class EnvApi {
  String basePath = "";
  String route;

  EnvApi({required this.route});

  String generateUri() {
    return basePath + route;
  }
}