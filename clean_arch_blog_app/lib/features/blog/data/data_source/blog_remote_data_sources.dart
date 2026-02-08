import 'dart:io';

import 'package:clean_arch_blog_app/core/error/exceptions.dart';
import 'package:clean_arch_blog_app/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract interface class BlogRemoteDataSources {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage({required File image, required String blogId});
}

class BlogRemoteDataSourcesImpl implements BlogRemoteDataSources {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  BlogRemoteDataSourcesImpl(this._firebaseFirestore, this._firebaseStorage);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      await _firebaseFirestore
          .collection('blogs')
          .doc(blog.blogId)
          .set(blog.toJson());
      return BlogModel.fromJson(blog.toJson());
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required String blogId,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child('uploads/blogs/$blogId');

      final uploadTask = await ref.putFile(image);

      final url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
