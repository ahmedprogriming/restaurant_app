import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/widgets/custom_auth_header.dart';
import 'package:restaurant/widgets/custom_back_button.dart';
import 'package:restaurant/widgets/custom_primary_button.dart';
import 'package:restaurant/widgets/custom_rounded_text_field.dart';
import 'package:restaurant/widgets/custom_snackbar.dart';

/// Clean and modern Forgot Password screen matching the exact reference design mockup.
/// Reuses core components: CustomRoundedTextField, CustomPrimaryButton, CustomBackButton,
/// CustomAuthHeader, and showAppSnackbar.
class ForgotPasswordScreen extends StatefulWidget {
  final bool initialIsArabic;

  const ForgotPasswordScreen({
    super.key,
    this.initialIsArabic = false,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  late bool _isArabic;
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void initState() {
    super.initState();
    _isArabic = widget.initialIsArabic;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  // Handle Send action
  Future<void> _handleSend() async {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    // Simulate sending password reset email
    await Future.delayed(const Duration(milliseconds: 1100));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _emailSent = true;
    });

    showAppSnackbar(
      context,
      _isArabic
          ? 'تم إرسال رابط إعادة تعيين كلمة المرور إلى ${_emailController.text.trim()}'
          : 'Password reset link sent to ${_emailController.text.trim()}',
      type: SnackBarType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = _isArabic ? TextDirection.rtl : TextDirection.ltr;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: textDirection,
          child: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.opaque,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 26.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1. Top Bar with back chevron (<) and subtle language switch
                              _buildTopBar(),

                              const SizedBox(height: 28),

                              // 2. Title and Description Header
                              CustomAuthHeader(
                                title: _isArabic
                                    ? 'نسيت كلمة المرور'
                                    : 'Forgot password',
                                subtitle: _isArabic
                                    ? 'يرجى إدخال بريدك الإلكتروني لاستلام رابط لإنشاء كلمة مرور جديدة عبر البريد الإلكتروني.'
                                    : 'Please enter your email to receive a link to create a new password via email.',
                                titleFontSize: 28,
                                subtitleFontSize: 15,
                                spacing: 14,
                              ),

                              const SizedBox(height: 36),

                              // 3. Reusable Rounded Email Text Field
                              CustomRoundedTextField(
                                controller: _emailController,
                                focusNode: _emailFocus,
                                hintText: _isArabic ? 'البريد الإلكتروني' : 'Email',
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _handleSend(),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return _isArabic
                                        ? 'يرجى إدخال البريد الإلكتروني'
                                        : 'Please enter your email';
                                  }
                                  final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                  );
                                  if (!emailRegex.hasMatch(value.trim())) {
                                    return _isArabic
                                        ? 'صيغة البريد الإلكتروني غير صحيحة'
                                        : 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 22),

                              // 4. Reusable Primary Button ("Send")
                              CustomPrimaryButton(
                                text: _isArabic ? 'إرسال' : 'Send',
                                isLoading: _isLoading,
                                onPressed: _handleSend,
                              ),

                              if (_emailSent) ...[
                                const SizedBox(height: 24),
                                _buildSuccessCard(),
                              ],

                              const Spacer(),

                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 1. Top Bar with Reusable Back Chevron (<) and language toggle
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Reusable back button matching the design
          CustomBackButton(
            isRtl: _isArabic,
            onPressed: () => Navigator.of(context).maybePop(),
          ),

          // Language toggle chip
          InkWell(
            onTap: () {
              setState(() {
                _isArabic = !_isArabic;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFEDEEF2),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.language_rounded,
                    size: 15,
                    color: Color(0xFF6B7280),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _isArabic ? 'English' : 'عربي',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Informative card shown after the email has been sent successfully
  Widget _buildSuccessCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FFF4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF48BB78).withValues(alpha: 0.3),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF48BB78).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF2F855A),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _isArabic
                  ? 'تم إرسال رابط استعادة كلمة المرور، يرجى مراجعة بريدك الإلكتروني.'
                  : 'Reset link sent! Please check your email inbox to proceed.',
              style: const TextStyle(
                color: Color(0xFF22543D),
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
