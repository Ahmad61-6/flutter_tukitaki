import 'package:get/get.dart';

class AddNewBlogPageController extends GetxController {
  final RxInt _selectedCategoryIndex = 0.obs;

  RxInt get selectedCategoryIndex => _selectedCategoryIndex;

  void changeBlogCategory(int index) {
    if (index != _selectedCategoryIndex.value) {
      _selectedCategoryIndex.value = index;
    } else {
      return;
    }
  }
}
