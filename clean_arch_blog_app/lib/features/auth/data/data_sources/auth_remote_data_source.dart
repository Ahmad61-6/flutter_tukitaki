import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/error/exceptions.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    File? image,
  });

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Stream<User?> get authStateChanges;

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._firebaseStorage);

  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    File? image,
  }) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw ServerException('User creation failed');
      }
      String? imageUrl;
      if (image != null) {
        imageUrl = await _uploadImage(image: image, userId: response.user!.uid);
      }
      await response.user!.updateDisplayName(name);
      await response.user!.reload();

      if (imageUrl != null) {
        await response.user!.updatePhotoURL(imageUrl);
      }
      return response.user!.uid;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw ServerException('No user found for that email.');
        case 'wrong-password':
          throw ServerException('Wrong password provided.');
        case 'invalid-credential':
          throw ServerException('Invalid email or password.');
        case 'user-disabled':
          throw ServerException('This user has been disabled.');
        case 'invalid-email':
          throw ServerException('The email address is not valid.');
        case 'too-many-requests':
          throw ServerException(
            'Too many login attempts. Please try again later.',
          );
        case 'network-request-failed':
          throw ServerException('No internet connection.');
        default:
          throw ServerException(e.message ?? 'Login failed. Please try again.');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  Future<String> _uploadImage({
    required File image,
    required String userId,
  }) async {
    try {
      final Reference ref = _firebaseStorage
          .ref()
          .child('users')
          .child(userId)
          .child('profile_pic');
      final UploadTask uploadTask = ref.putFile(image);
      final TaskSnapshot snapshot = await uploadTask;
      return snapshot.ref.getDownloadURL();
    } catch (e) {
      throw ServerException('Failed to upload profile image.');
    }
  }
}
