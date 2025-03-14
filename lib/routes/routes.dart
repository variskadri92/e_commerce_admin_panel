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


  static const banners = '/banners';
  static const createBanners = '/createBanners';
  static const editBanners = '/editBanners';



  static const products = '/products';
  static const createProducts = '/createProducts';
  static const editProducts = '/editProducts';

  static const customers = '/customers';

  static List sideBarMenuItems = [
    dashboard,
    media,
    categories,
    brands,
    banners,
    products,
    customers,
  ];
}
