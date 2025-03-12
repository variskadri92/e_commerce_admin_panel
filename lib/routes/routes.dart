class Routes {
  static const login = '/login';
  static const forgetPassword = '/forget-password/';
  static const resetPassword = '/reset-password';
  static const dashboard = '/dashboard';
  static const media = '/media';

  static const categories = '/categories';
  static const createCategories = '/createCategories';
  static const editCategories = '/editCategories';
  
  static const brands = '/brands';
  static const createBrands = '/createBrands';
  static const editBrands = '/editBrands';

  static List sideBarMenuItems = [
    dashboard,
    media,
    categories,
    brands,
  ];
}
