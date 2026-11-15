import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/widgets/custom_primary_button.dart';
import 'package:restaurant/widgets/custom_rounded_text_field.dart';
import 'package:restaurant/widgets/custom_snackbar.dart';

/// Screen for changing user password ("شاشة تغيير كلمة المرور").
///
/// Designed to match the reference mockup:
/// - Top bar with back chevron (<) on the top left
/// - Coral/Red right-aligned title: "تغيير كلمة المرور"
/// - 3 rounded stadium input fields:
///   1. "كلمة المرور الحالية" (Current Password)
///   2. "كلمة المرور الجديدة" (New Password)
///   3. "تأكيد كلمة المرور" (Confirm Password)
/// - Coral rounded pill action button: "حفظ" (Save)
/// - Full RTL (Arabic) & LTR (English) support
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Focus Nodes
  final FocusNode _currentFocus = FocusNode();
  final FocusNode _newFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  // Obscure text toggles
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentFocus.dispose();
    _newFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  Future<void> _handleSavePassword(bool isArabic) async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    // Simulate backend password update
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() => _isLoading = false);

    showAppSnackbar(
      context,
      isArabic
          ? 'تم تغيير كلمة المرور بنجاح'
          : 'Password changed successfully',
      type: SnackBarType.success,
    );

    // Pop back to account screen after saving
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppLanguage.currentLocale,
      builder: (context, _) {
        final isArabic = AppLanguage.isArabic;
        final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Directionality(
            textDirection: textDirection,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  behavior: HitTestBehavior.opaque,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 12),

                          // 1. Top Bar with back chevron (<) on the top left (matching screenshot)
                          _buildTopBar(isArabic),

                          const SizedBox(height: 24),

                          // 2. Title "تغيير كلمة المرور" in coral red, aligned to the right (in Arabic)
                          Align(
                            alignment: isArabic
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Text(
                              isArabic ? 'تغيير كلمة المرور' : 'Change Password',
                              style: const TextStyle(
                                color: AppColor.primary,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // 3. Field 1: Current Password ("كلمة المرور الحالية")
                          CustomRoundedTextField(
                            controller: _currentPasswordController,
                            focusNode: _currentFocus,
                            hintText: isArabic
                                ? 'كلمة المرور الحالية'
                                : 'Current Password',
                            obscureText: _obscureCurrent,
                            textInputAction: TextInputAction.next,
                            fillColor: Colors.white,
                            borderRadius: 28,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.035),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureCurrent
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                                color: const Color(0xFFB0B7C3),
                              ),
                              onPressed: () {
                                setState(() => _obscureCurrent = !_obscureCurrent);
                              },
                              splashRadius: 20,
                            ),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_newFocus);
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return isArabic
                                    ? 'يرجى إدخال كلمة المرور الحالية'
                                    : 'Please enter current password';
                              }
                              if (value.length < 6) {
                                return isArabic
                                    ? 'كلمة المرور يجب أن لا تقل عن 6 أحرف'
                                    : 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 18),

                          // 4. Field 2: New Password ("كلمة المرور الجديدة")
                          CustomRoundedTextField(
                            controller: _newPasswordController,
                            focusNode: _newFocus,
                            hintText: isArabic
                                ? 'كلمة المرور الجديدة'
                                : 'New Password',
                            obscureText: _obscureNew,
                            textInputAction: TextInputAction.next,
                            fillColor: Colors.white,
                            borderRadius: 28,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.035),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureNew
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                                color: const Color(0xFFB0B7C3),
                              ),
                              onPressed: () {
                                setState(() => _obscureNew = !_obscureNew);
                              },
                              splashRadius: 20,
                            ),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_confirmFocus);
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return isArabic
                                    ? 'يرجى إدخال كلمة المرور الجديدة'
                                    : 'Please enter new password';
                              }
                              if (value.length < 6) {
                                return isArabic
                                    ? 'كلمة المرور الجديدة يجب أن تكون 6 أحرف على الأقل'
                                    : 'New password must be at least 6 characters';
                              }
                              if (value == _currentPasswordController.text) {
                                return isArabic
                                    ? 'كلمة المرور الجديدة مطابقة لكلمة المرور الحالية'
                                    : 'New password cannot be the same as current password';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 18),

                          // 5. Field 3: Confirm Password ("تأكيد كلمة المرور")
                          CustomRoundedTextField(
                            controller: _confirmPasswordController,
                            focusNode: _confirmFocus,
                            hintText: isArabic
                                ? 'تأكيد كلمة المرور'
                                : 'Confirm Password',
                            obscureText: _obscureConfirm,
                            textInputAction: TextInputAction.done,
                            fillColor: Colors.white,
                            borderRadius: 28,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.035),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirm
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                                color: const Color(0xFFB0B7C3),
                              ),
                              onPressed: () {
                                setState(() => _obscureConfirm = !_obscureConfirm);
                              },
                              splashRadius: 20,
                            ),
                            onFieldSubmitted: (_) => _handleSavePassword(isArabic),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return isArabic
                                    ? 'يرجى تأكيد كلمة المرور'
                                    : 'Please confirm password';
                              }
                              if (value != _newPasswordController.text) {
                                return isArabic
                                    ? 'كلمة المرور غير متطابقة'
                                    : 'Passwords do not match';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 30),

                          // 6. Action Button: "حفظ" (Save) in Coral/Red Pill Shape
                          CustomPrimaryButton(
                            text: isArabic ? 'حفظ' : 'Save',
                            isLoading: _isLoading,
                            borderRadius: 28,
                            height: 52,
                            fontSize: 16.5,
                            fontWeight: FontWeight.w700,
                            backgroundColor: AppColor.primary,
                            hasShadow: true,
                            onPressed: () => _handleSavePassword(isArabic),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Top Bar with Left Chevron (<) matching the reference screenshot exactly.
  Widget _buildTopBar(bool isArabic) {
    return Align(
      // The screenshot clearly shows the back arrow on the left side of the top bar
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.of(context).maybePop(),
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            child: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
              color: AppColor.textDark,
            ),
          ),
        ),
      ),
    );
  }
}
