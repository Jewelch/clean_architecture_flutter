enum AppEnvironments {
  mock(),
  dev(googleApiKey: "devApiKey"),
  prod(googleApiKey: "prodApiKey");

  final String googleApiKey;

  const AppEnvironments({this.googleApiKey = ""});

  static const baseUrl = "https://dummyjson.com";
}
