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
  static const customerDetail = '/customerDetail';

  static const orders = '/orders';
  static const orderDetail = '/orderDetail';

  static const profile = '/profile';
  static const coupons = '/coupons';
  static const createCoupons = '/createCoupons';
  static const editCoupons = '/editCoupons';
  static const settings = '/settings';

  static List sideBarMenuItems = [
    dashboard,
    media,
    categories,
    brands,
    banners,
    products,
    customers,
    orders,
    settings,
    profile
  ];
}
