import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizer.dart';
import '../../../../core/common/widgets/error_state_widget.dart';
import '../../../../core/common/widgets/pagination_loader.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductController controller = Get.find<ProductController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        controller.getProducts(isRefresh: false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Obx(() {

        // 1. Loading State
        if (controller.isInitialLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Error State (Using new Reusable Widget)
        if (controller.errorMessage.isNotEmpty) {
          return ErrorStateWidget(
            errorMessage: controller.errorMessage.value,
            onRetry: () => controller.getProducts(isRefresh: true),
          );
        }

        // 3. Empty State
        if (controller.productList.isEmpty) {
          return const Center(child: Text("No products found."));
        }

        // 4. Success / List State
        return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.all(16.w),
          itemCount: controller.productList.length + (controller.canLoadMore ? 1 : 0),
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {

            if (index == controller.productList.length) {
              return const PaginationLoader();
            }

            final product = controller.productList[index];
            return ProductCard(
              product: product,
              onTap: () {
                Get.toNamed(AppRoutes.productDetails, arguments: product);
              },
            );
          },
        );
      }),
    );
  }
}