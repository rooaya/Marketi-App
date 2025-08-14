class AppAssets {
  // Image Paths
  static const String logo = 'assets/images/logo.png';
  static const String appIcon = 'assets/images/app_icon.png';
  static const String splashBackground = 'assets/images/splash_bg.png';
  static const String authBackground = 'assets/images/auth_bg.png';
  static const String placeholder = 'assets/images/placeholder.png';
  static const String errorImage = 'assets/images/placeholder.png';
  static const String emptyCart = 'assets/images/placeholder.png';
  static const String emptyWishlist = 'assets/images/placeholder.png';
  static const String emptyOrders = 'assets/images/placeholder.png';
  static const String paymentSuccess = 'assets/images/payment_success.png';
  static const String paymentFailed = 'assets/images/placeholder.png';
  static const String onboarding1 = 'assets/images/onboarding_1.png';
  static const String onboarding2 = 'assets/images/onboarding_2.png';
  static const String onboarding3 = 'assets/images/onboarding_3.png';
  static const String forgotPassphon = 'assets/images/forgetpass.png';
  static const String forgotpassEmail = 'assets/images/forgotpassemail.png';
  static const String verificationcode = 'assets/images/verifycode.png';
  static const String verificationcodeEmail =
      'assets/images/verifycodeEmail.png';
  static const String createnewpass = 'assets/images/newpassword.png';
  static const String congratespass = 'assets/images/congrateschangepass.png';
  static const String notsignin = 'assets/images/notsignin.png';
  static const String congratecheckout = 'assets/images/congrate.png';
  static const String offers = 'assets/images/offers.png';
  static const String circleravatar = 'assets/images/circleavatar.png';

  // Category Images
  static const String electronics = 'assets/icons/categories/electronics.png';
  static const String fashion = 'assets/icons/categories/fashion.png';
  static const String furniture = 'assets/icons/categories/furniture.png';
  static const String plants = 'assets/icons/categories/plants.png';
  static const String food = 'assets/icons/categories/food.png';
  static const String phones = 'assets/icons/categories/phones.png';
  static const String Games = 'assets/images/games.png';
  static const String airbods = 'assets/images/Airbods.png';
  static const String TV = 'assets/images/TV.png';
  static const String watch = 'assets/images/watch.png';
  static const String laptop = 'assets/images/laptop.png';
  static const String headphone = 'assets/images/headphones.png';
  static const String ankle = 'assets/images/ankle.png';
  static const String camera = 'assets/images/camera.png';
  static const String lose = ' assets/images/lose.png';
  static const String cornflex = 'assets/images/cornflex.png';
  static const String losee = 'assets/images/losee.png';

  //brand images
  static const String TownTeam = 'assets/images/TownTeamBrand.png';
  static const String JBL = 'assets/images/JBLBrands.png';
  static const String Pampers = 'assets/images/Pampers.png';
  static const String Canon = 'assets/images/CanonBrand.png';
  static const String Apple = 'asstes/images/AppleIcon.png';
  static const String adidas = 'asstes/images/AdidasIcon.png';
  static const String lacost = 'asstes/images/LacostIcon.png';
  static const String toshipa = 'asstes/images/ToshipaIcon.png';

  // App Icons
  static const String homeFilled = 'assets/icons/app/home_filled.png';
  static const String homeOutlined = 'assets/icons/app/home_outlined.png';
  static const String searchFilled = 'assets/icons/app/search_filled.png';
  static const String searchOutlined = 'assets/icons/app/search_outlined.png';
  static const String cartFilled = 'assets/icons/app/cart_filled.png';
  static const String cartOutlined = 'assets/icons/app/cart_outlined.png';
  static const String ordersFilled = 'assets/icons/app/orders_filled.png';
  static const String ordersOutlined = 'assets/icons/app/orders_outlined.png';
  static const String profileFilled = 'assets/icons/app/profile_filled.png';
  static const String profileOutlined = 'assets/icons/app/profile_outlined.png';

  // Social Icons
  static const String google = 'assets/icons/social/google.png';
  static const String facebook = 'assets/icons/social/facebook.png';
  static const String apple = 'assets/icons/social/apple.png';
  static const String twitter = 'assets/icons/social/twitter.png';

  // Payment Icons
  static const String visa = 'assets/icons/payment/visa.png';
  static const String mastercard = 'assets/icons/payment/mastercard.png';
  static const String paypal = 'assets/icons/payment/paypal.png';
  static const String applePay = 'assets/icons/payment/apple_pay.png';
  static const String googlePay = 'assets/icons/payment/google_pay.png';

  // Product Placeholders
  static const String productPlaceholder1 =
      'assets/images/products/product_1.jpg';
  static const String productPlaceholder2 =
      'assets/images/products/product_2.jpg';
  static const String productPlaceholder3 =
      'assets/images/products/product_3.jpg';

  // Lottie Animations
  static const String loadingAnimation = 'assets/lottie/loading.json';
  static const String successAnimation = 'assets/lottie/success.json';
  static const String errorAnimation = 'assets/lottie/error.json';
  static const String emptyAnimation = 'assets/lottie/empty.json';
  static const String connectionLostAnimation =
      'assets/lottie/connection_lost.json';

  // Helper Methods
  static String getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'logo':
        return logo;
      case 'appIcon':
        return appIcon;
      case 'splashBackground':
        return splashBackground;
      case 'authBackground':
        return authBackground;
      case 'placeholder':
        return placeholder;
      case 'errorImage':
        return placeholder;
      case 'emptyCart':
        return placeholder;
      case 'emptyWishlist':
        return placeholder;
      case ' emptyOrders':
        return placeholder;
      case 'paymentSuccess':
        return paymentSuccess;
      case 'paymentFailed':
        return placeholder;
      case 'onboarding1':
        return onboarding1;
      case 'onboarding2':
        return onboarding2;
      case 'onboarding3':
        return onboarding3;
      case 'forgotpassphon':
        return forgotPassphon;
      case 'forgotpassEmail':
        return forgotpassEmail;
      case 'verificationcode':
        return verificationcode;
      case 'verificationcodeEmail':
        return verificationcodeEmail;
      case 'createnewpass':
        return createnewpass;
      case 'congratespass':
        return congratespass;
      case 'notsignin':
        return notsignin;
      case 'congratecheckout':
        return congratecheckout;
      case 'offers':
        return offers;
      case 'circleravatar':
        return circleravatar;
      case 'electronics':
        return electronics;
      case 'fashion':
        return fashion;
      case 'furniture':
        return furniture;
      case 'plants':
        return plants;
      case 'food':
        return food;
      case 'phones':
        return phones;
      case 'Games':
        return Games;
      case 'TownTeamBrand':
        return TownTeam;
      case 'JBLBrands':
        return JBL;
      case 'Pampers':
        return Pampers;
      case 'CanonBrand':
        return Canon;
      case 'AppleIcon':
        return apple;
      case 'AdidasIcon':
        return adidas;
      case 'LacostIcon':
        return lacost;
      case 'ToshipaIcon':
        return toshipa;
      case 'airbods':
        return airbods;
      case 'TV':
        return TV;
      case 'watch':
        return watch;
      case 'laptop':
        return laptop;
      case "headphone":
        return headphone;
      case 'camera':
        return camera;
      case 'ankle':
        return ankle;
      case 'lose':
        return lose;
      case 'cornflex':
        return cornflex;
      case 'losee':
        return losee;

      default:
        return placeholder;
    }
  }

  static String getPaymentIcon(String paymentMethod) {
    switch (paymentMethod.toLowerCase()) {
      case 'visa':
        return visa;
      case 'mastercard':
        return mastercard;
      case 'paypal':
        return paypal;
      case 'apple pay':
        return applePay;
      case 'google pay':
        return googlePay;
      default:
        return placeholder;
    }
  }
}
