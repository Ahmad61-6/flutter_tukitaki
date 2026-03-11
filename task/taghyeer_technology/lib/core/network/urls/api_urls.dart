class ApiUrls {

  static const String baseUrl = 'https://dummyjson.com';

  static const String login = '$baseUrl/auth/login';


  static const String products = '$baseUrl/products';
  static const String posts = '$baseUrl/posts';


  static String paginatedProducts(int limit, int skip) =>
      '$products?limit=$limit&skip=$skip';

  static String paginatedPosts(int limit, int skip) =>
      '$posts?limit=$limit&skip=$skip';
}