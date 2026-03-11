import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/connection/connection_checker.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final ConnectionChecker _connectionChecker;

  ProductRepositoryImpl(this._remoteDataSource, this._connectionChecker);

  @override
  Future<Either<Failure, PaginatedProductsEntity>> getProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      if (!await _connectionChecker.isConnected) {
        return left(Failure('No internet connection'));
      }
      final result = await _remoteDataSource.getProducts(limit, skip);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure('An unexpected error occurred'));
    }
  }
}