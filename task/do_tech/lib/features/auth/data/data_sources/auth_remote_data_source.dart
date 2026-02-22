import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
    File? image,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Stream<User?> get authStateChanges;

  Future<void> signOut();

  Future<UserModel> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRemoteDataSourceImpl(
      this._firebaseAuth,
      this._firebaseFirestore,
      );

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw ServerException('User login failed');
      }
      debugPrint("------->> User Login Successful <<-------");
      final uid = response.user!.uid;
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('login_logs')
          .add({
        'timestamp': FieldValue.serverTimestamp(),
        'method': 'email_password',
      });

      final docSnap = await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .get();
      if (!docSnap.exists) {
        throw ServerException('User not found');
      }

      return UserModel.fromFirestore(docSnap, null);
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
        default:
          throw ServerException(e.message ?? 'An unknown error occurred.');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
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
      debugPrint("------->> User Creation Successful <<-------");

      await response.user!.updateDisplayName(name);
      await response.user!.reload();

      final newUser = UserModel(
        uId: response.user!.uid,
        name: name,
        email: email,
      );
      await _firebaseFirestore
          .collection('users')
          .doc(response.user!.uid)
          .set(newUser.toFirestore());

      return newUser;
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
  Future<void> signOut() async {
    try {
      debugPrint("------->> Signing out user <<-------");
      await _firebaseAuth.signOut();
      debugPrint("------->> User signed out successfully <<-------");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }


  @override
  Future<UserModel> getCurrentUserData() async {
    try {
      debugPrint(
        "------->> Fetching current user data from Firebase Firestore <<-------",
      );
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw ServerException('User not logged in');
      }
      final uid = currentUser.uid;

      final documentSnapshot = await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .get();
      if (!documentSnapshot.exists) {
        throw ServerException('User profile not found');
      }
      debugPrint("------->> Current user data fetched successfully <<-------");
      return UserModel.fromFirestore(documentSnapshot, null);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
