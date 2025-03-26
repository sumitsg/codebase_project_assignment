class ApiUrls {
  static const String baseUrl = 'https://reqres.in/api/';

  static String getUsersList(int perPage, int pageNumber) {
    return "${baseUrl}users?per_page=$perPage&page=$pageNumber";
  }

  static bool isSuccessful(int statusCode) =>
      statusCode > 199 && statusCode < 300;
}
