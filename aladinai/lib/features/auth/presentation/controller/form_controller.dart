import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/models/user_info.dart';
import '../../../../core/service/image_picker_service.dart';

class FormController extends GetxController {
  // Dependencies
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final ImagePickerService _imagePickerService = Get.find<ImagePickerService>();

  // Form State
  final formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController bioController;

  // UI State
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  File? _profileImage;
  File? get profileImage => _profileImage;

  static const String _userKey = 'current_user';

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    bioController = TextEditingController();

    _loadUserData();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.onClose();
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    // Basic email regex
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value);
    if (!emailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  void _loadUserData() {
    try {
      final userString = _prefs.getString(_userKey);
      if (userString != null) {
        final userJson = json.decode(userString) as Map<String, dynamic>;
        final user = UserModel.fromJson(userJson);

        firstNameController.text = user.firstName;
        lastNameController.text = user.lastName;
        emailController.text = user.email;
        phoneController.text = user.phoneNumber ?? '';
        bioController.text = user.bio ?? '';

        if (user.profilePictureUrl != null) {
          final file = File(user.profilePictureUrl!);
          if (file.existsSync()) {
            _profileImage = file;
          }
        }
        if (kDebugMode) {
          print('[FormController] User data loaded successfully.');
        }
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print('[FormController] Failed to load user data: $e');
      }
    }
  }

  Future<void> pickImage() async {
    final file = await _imagePickerService.pickAndCompressImage();
    if (file != null) {
      _profileImage = file;
      update();
    }
  }

  Future<bool> submitForm() async {
    if (!formKey.currentState!.validate()) {
      if (kDebugMode) {
        print('[FormController] Form is invalid.');
      }
      return false;
    }

    _setLoading(true);

    try {
      final user = UserModel(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber: phoneController.text.trim().isNotEmpty
            ? phoneController.text.trim()
            : null,
        bio: bioController.text.trim().isNotEmpty
            ? bioController.text.trim()
            : null,
        profilePictureUrl: _profileImage?.path,
      );

      final userJson = user.toJson();
      await _prefs.setString(_userKey, json.encode(userJson));

      if (kDebugMode) {
        print('[FormController] User data saved to SharedPreferences.');
      }

      Get.snackbar(
        'Success',
        'Profile saved successfully!',
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('[FormController] Error saving user data: $e');
      }

      Get.snackbar(
        'Error',
        'Failed to save profile. Please try again.',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    update();
  }
}
