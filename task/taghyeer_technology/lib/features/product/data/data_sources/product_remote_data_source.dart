import '../../../../core/network/network_client.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/urls/api_urls.dart';
import '../models/product_model.dart';
import '../../domain/entities/product_entity.dart';

abstract interface class ProductRemoteDataSource {
  Future<PaginatedProductsEntity> getProducts(int limit, int skip);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final NetworkClient _networkClient;

  ProductRemoteDataSourceImpl(this._networkClient);

  @override
  Future<PaginatedProductsEntity> getProducts(int limit, int skip) async {
    final response = await _networkClient.getRequest(
      ApiUrls.paginatedProducts(limit, skip),
    );

    if (response.isSuccess && response.responseData != null) {
      final data = response.responseData!;
      final List<dynamic> productsJson = data['products'];

      final products = productsJson.map((json) => ProductModel.fromJson(json)).toList();
      final total = data['total'] as int;

      return PaginatedProductsEntity(products: products, total: total);
    } else {
      throw ServerException(response.errorMessage ?? 'Failed to fetch products');
    }
  }
}