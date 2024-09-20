class ApiPath {
  static const String baseUrl = 'https://dummyjson-sm8j.onrender.com';
  static const String getProducts = '/products';
  static const String getProductDetail = "/products/";
  static const String getComment = "/comments/post";
  static const String getBrands = '/products/categories';
  static const String refreshToken = '/auth/refresh';
  static const String getBrandDetails = '/products/category/';
  static const String login = '/auth/login';
  static const String loginOnFirebase = '/auth/login-on-firebase';
  static const String addComment = '/comments/add';
  static const String getUser = '/auth/me';

  static const String getCart = '/carts/user';
  static const String search = '/products/search/';
  static const String loginGoogle =
      '/auth/login-social/minh-phu-ob3ee-45ccc0b07c';
  static const String registeredId = '/minh-phu-ob3ee-45ccc0b07c';
  static const String register = '/auth/register//minh-phu-ob3ee-45ccc0b07c';
  static const String checkUsernameExist =
      '/auth/check-username-exist/minh-phu-ob3ee-45ccc0b07c';
  static const String checkEmailExist =
      '/auth/check-email-exist/minh-phu-ob3ee-45ccc0b07c';
  static const String vertifyOtp = '/auth/verify-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';
}
