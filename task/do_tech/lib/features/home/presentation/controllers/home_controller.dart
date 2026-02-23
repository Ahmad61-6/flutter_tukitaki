import 'package:do_tech/core/utils/app_assets/assets_path.dart';
import 'package:get/get.dart';

import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';


class HomeController extends GetxController {
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchHomeData();
  }

  void _fetchHomeData() async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 2500));

    isLoading.value = false;
  }
  final List<CategoryModel> categories = [
    CategoryModel(id: '1', title: 'Cars', imagePath: AssetsPath.carImage),
    CategoryModel(id: '2', title: 'Bikes', imagePath: AssetsPath.bikesImage),
    CategoryModel(id: '3', title: 'CNG', imagePath: AssetsPath.autoImage),
    CategoryModel(id: '4', title: 'Truck &\nBuses', imagePath: AssetsPath.busImage),
  ];


  final List<String> promoBanners = [
    AssetsPath.bannerImage,
  ];

  final List<ProductModel> featuredProducts = [
    ProductModel(id: '1', title: 'PIAA Air Filter\nPT108', imagePath: AssetsPath.gridViewItem_1),
    ProductModel(id: '2', title: 'PIAA Oil Filter\nZ8M', imagePath: AssetsPath.gridViewItem_2),
    ProductModel(id: '3', title: 'PIAA Air Filter\nPT83', imagePath: AssetsPath.gridViewItem_3),
    ProductModel(id: '4', title: 'PIAA Air Filter\nPT108', imagePath: AssetsPath.gridViewItem_1),
    ProductModel(id: '5', title: 'PIAA Oil Filter\nZ8M', imagePath: AssetsPath.gridViewItem_2),
    ProductModel(id: '6', title: 'PIAA Air Filter\nPT83', imagePath: AssetsPath.gridViewItem_3),
  ];
}