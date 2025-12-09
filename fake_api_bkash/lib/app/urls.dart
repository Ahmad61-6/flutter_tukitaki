class Urls{
  static const appName = "Fake bkash app";
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';

  static const String signupUrl = "$_baseUrl/createProfile";
  static const String verifyOtpUrl = "$_baseUrl/Userlogin/";
  static  String loginUrl(String email) => "$_baseUrl/Userlogin/$email";
  static const String homeSliderUrl = "$_baseUrl/slides";




}