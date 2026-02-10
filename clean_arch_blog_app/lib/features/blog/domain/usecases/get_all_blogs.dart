import 'package:clean_arch_blog_app/core/error/failure.dart';
import 'package:clean_arch_blog_app/core/usecases/usecases.dart';
import 'package:clean_arch_blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/blog.dart';

class GetAllBlogs implements UseCases<List<Blog>, NoParams> {
  final BlogRepository _blogRepository;

  GetAllBlogs(this._blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await _blogRepository.getAllBlogs();
  }
}

class NoParams {}
