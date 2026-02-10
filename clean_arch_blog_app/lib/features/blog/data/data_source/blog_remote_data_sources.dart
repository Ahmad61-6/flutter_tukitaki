import 'dart:io';

import 'package:clean_arch_blog_app/core/error/exceptions.dart';
import 'package:clean_arch_blog_app/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

abstract interface class BlogRemoteDataSources {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage({required File image, required String blogId});

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourcesImpl implements BlogRemoteDataSources {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  BlogRemoteDataSourcesImpl(this._firebaseFirestore, this._firebaseStorage);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      debugPrint(
        "----->> Requesting to the Firebase Firestore to upload blog<<-----",
      );
      await _firebaseFirestore
          .collection('blogs')
          .doc(blog.blogId)
          .set(blog.toJson());
      debugPrint("----->> Request Successful <<-----");
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
      debugPrint(
        "----->> Requesting to the Firebase storage to upload image<<-----",
      );
      final ref = _firebaseStorage.ref().child('uploads/blogs/$blogId');

      final uploadTask = await ref.putFile(image);

      final url = await uploadTask.ref.getDownloadURL();
      debugPrint("----->> Request Successful <<-----\nImage URL: $url<<-----");
      return url;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      debugPrint(
        "----->> Requesting to the Firebase Firestore to get all blogs<<-----",
      );
      final querySnapShot = await _firebaseFirestore
          .collection('blogs')
          .orderBy('updated_at', descending: true)
          .get();
      final futures = querySnapShot.docs.map((doc) async {
        final data = BlogModel.fromJson(doc.data());
        final userDoc = await _firebaseFirestore
            .collection('users')
            .doc(data.posterId)
            .get();
        if (userDoc.exists) {
          final userData = userDoc.data();
          return data.copyWith(
            posterName: userData?['name'] ?? 'Unknown',
            posterAvatarUrl: userData?['profile_pic'] ?? '',
          );
        } else {
          return data.copyWith(posterName: 'Deleted User', posterAvatarUrl: '');
        }
      }).toList();
      final populatedBlogs = await Future.wait(futures);
      return populatedBlogs;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? "Unknown Firebase Error");
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
