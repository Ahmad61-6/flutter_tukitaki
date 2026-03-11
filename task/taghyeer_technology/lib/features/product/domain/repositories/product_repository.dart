import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/product_entity.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, PaginatedProductsEntity>> getProducts({
    required int limit,
    required int skip,
  });
}