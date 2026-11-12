import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/routers/app_routes.dart';
import 'package:restaurant/widgets/custom_rounded_text_field.dart';
import 'package:restaurant/widgets/custom_snackbar.dart';

/// Clean and modern Account Creation (Sign Up) screen
/// matching the exact reference design mockup.
class SignUpScreen extends StatefulWidget {
  final bool initialIsArabic;
  final bool matchMockupButtonText;

  const SignUpScreen({
    super.key,
    this.initialIsArabic = false,
    this.matchMockupButtonText = false,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Focus Nodes
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  // State flags
  late bool _isArabic;
  late bool _useMockupButtonText;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isArabic = widget.initialIsArabic;
    _useMockupButtonText = widget.matchMockupButtonText;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();

    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  // Submit & create account
  Future<void> _handleSignUp() async {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      showAppSnackbar(
        context,
        _isArabic
            ? 'يرجى التأكد من ملء جميع الحقول بشكل صحيح'
            : 'Please fill in all fields correctly',
        type: SnackBarType.warning,
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate network request
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;
    setState(() => _isLoading = false);

    showAppSnackbar(
      context,
      _isArabic
          ? 'مرحباً ${_usernameController.text.trim()}! تم إنشاء حسابك بنجاح'
          : 'Welcome ${_usernameController.text.trim()}! Account created successfully',
      type: SnackBarType.success,
    );

    // Navigate to Home screen
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (route) => false,
    );
  }

  // Navigate to login
  void _navigateToLogin() {
    Navigator.of(context).pushNamed(AppRoutes.login);
  }

  // Show terms & conditions bottom sheet
  void _showTermsDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              20,
              24,
              MediaQuery.of(context).padding.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _isArabic ? 'الشروط والأحكام' : 'Terms and Conditions',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _isArabic
                      ? 'باستخدامك لتطبيق المطعم، فإنك توافق على الالتزام بجميع بنود وسياسات الاستخدام والخصوصية المعمول بها لضمان أفضل تجربة لطلب وتوصيل الطعام.'
                      : 'By using this app, you agree to our Terms of Service and Privacy Policy ensuring the best food ordering and delivery experience.',
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      _isArabic ? 'فهمت ذلك' : 'I Understand',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. Top Navigation Bar (Back Arrow + Optional Language Toggle)
                            _buildTopBar(),

                            const SizedBox(height: 20),

                            // 2. Large Two-Line Title ("Create your\naccount")
                            _buildTitle(),

                            const SizedBox(height: 32),

                            // 3. Form with Rounded Input Fields
                            _buildForm(),

                            const SizedBox(height: 28),

                            // 4. Primary Red Action Button
                            _buildSubmitButton(),

                            const SizedBox(height: 18),

                            // 5. Terms and Conditions text
                            _buildTermsText(),

                            // Flexible space before bottom prompt
                            const Spacer(),

                            const SizedBox(height: 24),

                            // 6. Bottom "Already an account? Log in"
                            _buildFooterPrompt(),

                            const SizedBox(height: 16),
                          ],
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

  /// Top Bar with minimal Back Chevron and subtle language/mockup switcher
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button (<) matching the reference design
          InkWell(
            onTap: () => Navigator.of(context).maybePop(),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: Icon(
                _isArabic
                    ? Icons.arrow_forward_ios_rounded
                    : Icons.chevron_left_rounded,
                size: 28,
                color: AppColor.textDark,
              ),
            ),
          ),

          // Utility Actions: Language switcher & Mockup Button Text Switcher
          Row(
            children: [
              // Switch button label ("Sign up" vs exact mockup "Log in")
              InkWell(
                onTap: () {
                  setState(() {
                    _useMockupButtonText = !_useMockupButtonText;
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _useMockupButtonText
                        ? AppColor.primary.withValues(alpha: 0.1)
                        : const Color(0xFFF4F5F8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _useMockupButtonText ? 'Mockup: Log in' : 'Standard: Sign up',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _useMockupButtonText
                          ? AppColor.primary
                          : const Color(0xFF8D99AE),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Language toggle
              InkWell(
                onTap: () {
                  setState(() {
                    _isArabic = !_isArabic;
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.language_rounded,
                        size: 14,
                        color: AppColor.textDark,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _isArabic ? 'English' : 'عربي',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Big Coral Red Two-Line Headline
  Widget _buildTitle() {
    return Text(
      _isArabic ? 'إنشاء\nحسابك' : 'Create your\naccount',
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColor.primary,
        height: 1.18,
        letterSpacing: -0.5,
      ),
    );
  }

  /// Form with the 4 rounded fields: Username, Email, Password, Phone
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // 1. Username
          CustomRoundedTextField(
            controller: _usernameController,
            focusNode: _usernameFocus,
            hintText: _isArabic ? 'اسم المستخدم' : 'Username',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFocus);
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return _isArabic
                    ? 'يرجى إدخال اسم المستخدم'
                    : 'Please enter your username';
              }
              if (value.trim().length < 3) {
                return _isArabic
                    ? 'الاسم يجب ألا يقل عن 3 أحرف'
                    : 'Username must be at least 3 characters';
              }
              return null;
            },
          ),

          const SizedBox(height: 14),

          // 2. Email
          CustomRoundedTextField(
            controller: _emailController,
            focusNode: _emailFocus,
            hintText: _isArabic ? 'البريد الإلكتروني' : 'Email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocus);
            },
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

          const SizedBox(height: 14),

          // 3. Password
          CustomRoundedTextField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            hintText: _isArabic ? 'كلمة المرور' : 'Password',
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFFB0B7C3),
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_phoneFocus);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return _isArabic
                    ? 'يرجى إدخال كلمة المرور'
                    : 'Please enter a password';
              }
              if (value.length < 6) {
                return _isArabic
                    ? 'كلمة المرور يجب أن لا تقل عن 6 خانات'
                    : 'Password must be at least 6 characters';
              }
              return null;
            },
          ),

          const SizedBox(height: 14),

          // 4. Phone
          CustomRoundedTextField(
            controller: _phoneController,
            focusNode: _phoneFocus,
            hintText: _isArabic ? 'رقم الهاتف' : 'Phone',
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _handleSignUp(),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return _isArabic
                    ? 'يرجى إدخال رقم الهاتف'
                    : 'Please enter your phone number';
              }
              if (value.trim().length < 8) {
                return _isArabic
                    ? 'رقم الهاتف غير مكتمل'
                    : 'Phone number is too short';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  /// Primary Action Button (Vibrant Coral Red pill button)
  Widget _buildSubmitButton() {
    // Resolving button label:
    // If _useMockupButtonText is true, shows "Log in" as displayed on the screenshot mockup.
    // Otherwise shows "Sign up" (or "إنشاء حساب" in Arabic).
    final String buttonLabel = _useMockupButtonText
        ? (_isArabic ? 'تسجيل الدخول' : 'Log in')
        : (_isArabic ? 'إنشاء حساب' : 'Sign up');

    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withValues(alpha: 0.32),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColor.primary.withValues(alpha: 0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                buttonLabel,
                style: const TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
      ),
    );
  }

  /// Terms and conditions statement matching the reference mockup
  Widget _buildTermsText() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF6B7280),
              height: 1.45,
              fontWeight: FontWeight.w400,
            ),
            children: _isArabic
                ? [
                    const TextSpan(
                      text: 'بالنقر على إنشاء حساب، فإنك توافق على ',
                    ),
                    TextSpan(
                      text: 'الشروط والأحكام',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColor.textDark,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _showTermsDialog,
                    ),
                    const TextSpan(text: ' الخاصة بنا'),
                  ]
                : [
                    const TextSpan(
                      text: 'By clicking Sign up you agree to the our\n',
                    ),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColor.textDark,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _showTermsDialog,
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  /// Bottom prompt: "Already an account? Log in"
  Widget _buildFooterPrompt() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isArabic ? 'لديك حساب بالفعل؟ ' : 'Already an account? ',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2B2D42),
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: _navigateToLogin,
              child: Text(
                _isArabic ? 'تسجيل الدخول' : 'Log in',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
