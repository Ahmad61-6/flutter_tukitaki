import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, PaginatedProductsEntity>> call(int limit, int skip) async {
    return await repository.getProducts(limit: limit, skip: skip);
  }
}