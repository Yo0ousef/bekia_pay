enum AppRoutes {
  home("/home"),
  gate("/gate"),
  shop("/shop"),
  cart("/cart"),
  signUp("/signUp"),
  signIn("/signIn"),
  materials("/materials"),
  onBoarding("/onBoarding"),
  favourites("/favourites"),
  offerDetails("/offerDetails"),
  subscription("/subscription");

  final String route;

  const AppRoutes(this.route);

  static AppRoutes? fromRoute(String? route) {
    for (AppRoutes value in AppRoutes.values) {
      if (value.route == route) return value;
    }
    return null;
  }
}
