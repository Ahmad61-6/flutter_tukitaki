import 'package:get/get.dart';
import '../../../../core/helpers/app_helpers.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_products.dart';

class ProductController extends GetxController {
  final GetProducts getProductsUseCase;

  ProductController({required this.getProductsUseCase});

  final int _limit = 10;
  int _skip = 0;
  int _total = 0;

  final RxList<ProductEntity> productList = <ProductEntity>[].obs;
  final RxBool isInitialLoading = false.obs;
  final RxBool isPaginationLoading = false.obs;
  final RxString errorMessage = ''.obs;

  bool get canLoadMore => _skip + _limit < _total;

  Future<void> getProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      _skip = 0;
      isInitialLoading.value = true;
      errorMessage.value = '';
    } else {
      if (isPaginationLoading.value || !canLoadMore) return;
      isPaginationLoading.value = true;
      _skip += _limit;
    }

    final result = await getProductsUseCase.call(_limit, _skip);

    result.fold(
          (failure) {
        if (isRefresh) {
          errorMessage.value = failure.message;
        } else {
          _skip -= _limit;
          AppHelperFunctions.showSnackBar('Pagination Error', failure.message, true);
        }
      },
          (paginatedData) {
        _total = paginatedData.total;

        if (isRefresh) {
          productList.assignAll(paginatedData.products);
        } else {
          productList.addAll(paginatedData.products);
        }
      },
    );

    isInitialLoading.value = false;
    isPaginationLoading.value = false;
  }
}