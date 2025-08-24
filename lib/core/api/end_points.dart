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
  static String productbycategory = "/home/products/category/smartphones?skip=0&limit=5";
  static String productbybrand = "/home/products/brand/Essence?skip=0&limit=5";
  static String brands = "home/brands";
  static String brandname = "home/brands/names";

  static String categories = "home/categories";
  static String categorynames = "home/categories/names";

//! Cart  ------------------------------------------------------

  static String getcart = "user/getCart";
  static String addcart = "user/addCart";
  static String delcart = "user/deleteCart";

//! FAv  ------------------------------------------------------
static String getfav = "user/getFavorite";
static String addfav = "user/addFavorite";
static String delfav = "user/deleteFavorite";

}

class ApiKey {
  static String status = "status";
  static String errorMessage = "errorMessage";
  static String email = "email";
  static String password = "password";
  static String authorization = "Authorization";
}

class StorageKeys {
  static String hasCompletedOnboarding = "hasCompletedOnboarding";
  static String token = "token";
}

