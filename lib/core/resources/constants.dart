class AppConstants {
  // App Information
  static const String appName = 'Marketi';
  static const String appVersion = '1.0.0';
  static const String appSlogan = 'Shop Smarter, Live Better';

  // API Endpoints
  static const String baseUrl = 'https://api.marketi.com/v1';
  static const String productsEndpoint = '/products';
  static const String categoriesEndpoint = '/categories';
  static const String authEndpoint = '/auth';
  static const String userEndpoint = '/user';
  static const String cartEndpoint = '/cart';

  // Asset Paths
  static const String logoPath = 'assets/images/logo.png';
  static const String placeholderPath = 'assets/images/placeholder.png';
  static const String authBackgroundPath = 'assets/images/auth_bg.png';

  // Local Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String cartItemsKey = 'cart_items';
  static const String themeModeKey = 'theme_mode';

  // App Settings
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double defaultIconSize = 24.0;
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  // Text Constants
  static const String continueText = 'Continue';
  static const String getStarted = 'Get Started';
  static const String skip = 'Skip';
  static const String seeAll = 'See All';
  static const String addToCart = 'Add to Cart';
  static const String buyNow = 'Buy Now';
  static const String viewDetails = 'View Details';

  // Error Messages
  static const String networkError = 'Network Error';
  static const String serverError = 'Server Error';
  static const String invalidEmail = 'Please enter a valid email';
  static const String weakPassword = 'Password must be at least 6 characters';
  static const String emptyField = 'This field cannot be empty';

  // Success Messages
  static const String loginSuccess = 'Login Successful';
  static const String signupSuccess = 'Account Created Successfully';
  static const String orderPlaced = 'Order Placed Successfully';

  // Navigation Routes
  static const String homeRoute = '/home';
  static const String productRoute = '/product';
  static const String cartRoute = '/cart';
  static const String profileRoute = '/profile';
  static const String authRoute = '/auth';

  // Social Media
  static const String facebookUrl = 'https://facebook.com/marketi';
  static const String instagramUrl = 'https://instagram.com/marketi';
  static const String twitterUrl = 'https://twitter.com/marketi';

  // Payment Methods
  static const List<String> paymentMethods = [
    'Credit Card',
    'PayPal',
    'Cash on Delivery',
    'Bank Transfer'
  ];

  // Demo Data (Replace with actual API data)
  static const List<Map<String, dynamic>> demoCategories = [
    {'id': 1, 'name': 'Electronics', 'icon': 'assets/icons/electronics.png'},
    {'id': 2, 'name': 'Fashion', 'icon': 'assets/icons/fashion.png'},
    {'id': 3, 'name': 'Home', 'icon': 'assets/icons/home.png'},
    {'id': 4, 'name': 'Beauty', 'icon': 'assets/icons/beauty.png'},
  ];
}