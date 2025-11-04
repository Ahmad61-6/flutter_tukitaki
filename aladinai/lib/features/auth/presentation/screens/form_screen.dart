import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/features/home/presentation/screen/home_screen.dart';

import '../controller/form_controller.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});
  static const String name = '/form';

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GetBuilder<FormController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('User Form'),
            centerTitle: true,
            backgroundColor: colorScheme.surface,
            elevation: 0,
          ),
          body: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Header with Profile Picker ---
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primaryContainer.withValues(alpha: 0.8),
                          colorScheme.primary.withValues(alpha: 0.85),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _ProfileImagePicker(controller: controller),
                        const SizedBox(height: 16),
                        Text(
                          'Provide your profile information',
                          style: textTheme.titleLarge?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- Input Fields Card ---
                  Card(
                    elevation: 2,
                    color: colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildTextFormField(
                            controller: controller.firstNameController,
                            labelText: 'First Name',
                            hintText: 'Enter your first name',
                            icon: Icons.person_outline,
                            validator: (value) => controller.validateRequired(
                              value,
                              'First Name',
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTextFormField(
                            controller: controller.lastNameController,
                            labelText: 'Last Name',
                            hintText: 'Enter your last name',
                            icon: Icons.person_outline,
                            validator: (value) =>
                                controller.validateRequired(value, 'Last Name'),
                          ),
                          const SizedBox(height: 16),
                          _buildTextFormField(
                            controller: controller.emailController,
                            labelText: 'Email',
                            hintText: 'Enter your email address',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: controller.validateEmail,
                          ),
                          const SizedBox(height: 16),
                          _buildTextFormField(
                            controller: controller.phoneController,
                            labelText: 'Phone Number (Optional)',
                            hintText: 'Enter your phone number',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          _buildTextFormField(
                            controller: controller.bioController,
                            labelText: 'Bio (Optional)',
                            hintText: 'Tell us a bit about yourself...',
                            icon: Icons.edit_note_outlined,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- Save Button ---
                  ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () async {
                            final success = await controller.submitForm();
                            if (success) {
                              if (mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  HomeScreen.name,
                                );
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: controller.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Save Profile',
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: colorScheme.primary),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}

class _ProfileImagePicker extends StatelessWidget {
  final FormController controller;
  const _ProfileImagePicker({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: colorScheme.surface,
              backgroundImage: controller.profileImage != null
                  ? FileImage(controller.profileImage!)
                  : null,
              child: controller.profileImage == null
                  ? Icon(
                      Icons.person,
                      size: 60,
                      color: colorScheme.onSurface.withValues(alpha: 0.4),
                    )
                  : null,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Material(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: controller.pickImage,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.edit,
                    size: 20,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
