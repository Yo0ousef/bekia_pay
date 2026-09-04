enum AppRoutes {
  home("/home"),
  gate("/gate"),
  signIn("/signIn"),
  signUp("/signUp");

  final String route;

  const AppRoutes(this.route);

  static AppRoutes? fromRoute(String? route) {
    for (AppRoutes value in AppRoutes.values) {
      if (value.route == route) return value;
    }
    return null;
  }
}
