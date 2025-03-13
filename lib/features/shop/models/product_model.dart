class ProductModel {
  final String targetScreen;
  final bool active;
  final String imageUrl;

  ProductModel({
    required this.active,
    required this.imageUrl,
    required this.targetScreen,
  });

  static ProductModel empty() => ProductModel(active: false,imageUrl: '',targetScreen: '');
}

