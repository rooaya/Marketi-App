////! baseUrl
class EndPoints {

  static String baseUrl = "https://marketi-app.onrender.com/api/v1/";
  //! Auth  ------------------------------------------------------
  static String signIn = "auth/signIn";
  static String signUp = "auth/signUp";
  static String signOut = "auth/oAuth/signOut";
  static String sendPassEmail = "auth/sendPassEmail";
  static String activeResetPass = "auth/activeResetPass";
  static String resetPassword = "auth/resetPassword";
  //! Home  ------------------------------------------------------
  static String products = "home/products";
  static String brands = "home/brands";
  static String categories = "home/categories";

}

class ApiKey {
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  static String email = "email";
  static String password = "password";
  static String authorization = "Authorization";
}

class StorageKeys {
  static String hasCompletedOnboarding = "hasCompletedOnboarding";
  static String token = "token";
}