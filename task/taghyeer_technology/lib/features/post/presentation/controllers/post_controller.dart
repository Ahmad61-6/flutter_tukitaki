import 'package:get/get.dart';
import '../../../../core/helpers/app_helpers.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_posts.dart';

class PostController extends GetxController {
  final GetPosts getPostsUseCase;

  PostController({required this.getPostsUseCase});

  final int _limit = 10;
  int _skip = 0;
  int _total = 0;

  final RxList<PostEntity> postList = <PostEntity>[].obs;
  final RxBool isInitialLoading = false.obs;
  final RxBool isPaginationLoading = false.obs;
  final RxString errorMessage = ''.obs;

  bool get canLoadMore => _skip + _limit < _total;

  Future<void> getPosts({bool isRefresh = false}) async {
    if (isRefresh) {
      _skip = 0;
      isInitialLoading.value = true;
      errorMessage.value = '';
    } else {
      if (isPaginationLoading.value || !canLoadMore) return;
      isPaginationLoading.value = true;
      _skip += _limit;
    }

    final result = await getPostsUseCase.call(_limit, _skip);

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
          postList.assignAll(paginatedData.posts);
        } else {
          postList.addAll(paginatedData.posts);
        }
      },
    );

    isInitialLoading.value = false;
    isPaginationLoading.value = false;
  }
}