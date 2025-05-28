class FlavorValues {
  final String apiBaseUrl;
  // final AppSecrets secrets;

  final bool showLogs;
  final bool _logSqlStatements;

  final String appTitle;
  final String apiUrl;

  const FlavorValues({
    required this.apiBaseUrl,
    // required this.secrets,
    logSqlStatements = false,
    this.showLogs = false,
    this.appTitle = "MyApp DEV",
    this.apiUrl = "https://dev-api.example.com",
  }) : _logSqlStatements = showLogs && logSqlStatements;

  bool get logSqlStatements => _logSqlStatements;
}
