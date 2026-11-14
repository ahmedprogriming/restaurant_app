import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/routers/app_routes.dart';
import 'package:restaurant/widgets/custom_back_button.dart';
import 'package:restaurant/widgets/custom_primary_button.dart';
import 'package:restaurant/widgets/custom_snackbar.dart';

/// Clean and modern Login Screen matching the exact reference design mockup.
class LoginScreen extends StatefulWidget {
  final bool initialIsArabic;

  const LoginScreen({
    super.key,
    this.initialIsArabic = false,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Editing Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Focus Nodes
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  // State flags
  bool get _isArabic => AppLanguage.isArabic;
  final bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // Handle Login submission
  Future<void> _handleLogin() async {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      showAppSnackbar(
        context,
        _isArabic
            ? 'يرجى إدخال البريد الإلكتروني وكلمة المرور بشكل صحيح'
            : 'Please enter valid email and password',
        type: SnackBarType.warning,
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate authentication network call
    await Future.delayed(const Duration(milliseconds: 1100));

    if (!mounted) return;
    setState(() => _isLoading = false);

    showAppSnackbar(
      context,
      _isArabic
          ? 'تم تسجيل الدخول بنجاح! أهلاً بك مجدداً'
          : 'Logged in successfully! Welcome back',
      type: SnackBarType.success,
    );

    // Navigate to Home screen
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (route) => false,
    );
  }

  // Navigate to Sign Up screen
  void _navigateToSignUp() {
    Navigator.of(context).pushNamed(AppRoutes.signUp);
  }

  // Navigate to Forgot Password screen
  void _navigateToForgotPassword() {
    Navigator.of(context).pushNamed(
      AppRoutes.forgotPassword,
      arguments: _isArabic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppLanguage.currentLocale,
      builder: (context, _) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
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
                                  // 1. Top Navigation Bar (Back Arrow)
                                  _buildTopBar(),

                                  const SizedBox(height: 28),

                                  // 2. Large Two-Line Title ("Log in to your\naccount")
                                  _buildTitle(),

                                  const SizedBox(height: 38),

                                  // 3. Clean Grouped Card for Credentials (Email & Password + Forgot?)
                                  _buildCredentialsCard(),

                                  const SizedBox(height: 24),

                                  // 4. Primary Red/Coral Action Button ("Log in")
                                  _buildLoginButton(),

                                  // Flexible spacing to push the footer cleanly to the bottom
                                  const Spacer(),

                                  const SizedBox(height: 24),

                                  // 5. Bottom Prompt ("Don't have an account? Sign up")
                                  _buildFooterPrompt(),

                                  const SizedBox(height: 18),
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
      },
    );
  }

  /// 1. Top Bar with back chevron (<) matching the reference mockup
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: CustomBackButton(
          isRtl: _isArabic,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }

  /// 2. Large Two-Line Title matching the mockup
  Widget _buildTitle() {
    return Text(
      _isArabic
          ? 'تسجيل الدخول\nإلى حسابك'
          : 'Log in to your\naccount',
      style: const TextStyle(
        fontSize: 32,
        height: 1.18,
        fontWeight: FontWeight.w700,
        color: AppColor.primary,
        letterSpacing: -0.4,
      ),
    );
  }

  /// 3. Minimalist Grouped Input Card containing Email and Password
  Widget _buildCredentialsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFF0F1F5),
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Email Field
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocus,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: AppColor.primary,
            style: const TextStyle(
              color: AppColor.textDark,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: _isArabic ? 'البريد الإلكتروني' : 'Email',
              hintStyle: const TextStyle(
                color: Color(0xFFB0B7C3),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 18,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return _isArabic
                    ? 'يرجى إدخال البريد الإلكتروني'
                    : 'Please enter your email';
              }
              final emailRegex =
                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value.trim())) {
                return _isArabic
                    ? 'صيغة البريد الإلكتروني غير صحيحة'
                    : 'Please enter a valid email address';
              }
              return null;
            },
          ),

          // Subtle Divider Line
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF3F4F7),
            indent: 16,
            endIndent: 16,
          ),

          // Password Field with inline "Forgot?" button
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  cursorColor: AppColor.primary,
                  onFieldSubmitted: (_) => _handleLogin(),
                  style: const TextStyle(
                    color: AppColor.textDark,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: _isArabic ? 'كلمة المرور' : 'Password',
                    hintStyle: const TextStyle(
                      color: Color(0xFFB0B7C3),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 18,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _isArabic
                          ? 'يرجى إدخال كلمة المرور'
                          : 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return _isArabic
                          ? 'كلمة المرور يجب أن لا تقل عن 6 أحرف'
                          : 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),

              // "Forgot?" text button matching mockup
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 18.0),
                child: GestureDetector(
                  onTap: _navigateToForgotPassword,
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    _isArabic ? 'نسيت؟' : 'Forgot?',
                    style: const TextStyle(
                      color: AppColor.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 4. Primary Red/Coral "Log in" pill button matching the mockup
  Widget _buildLoginButton() {
    return CustomPrimaryButton(
      text: _isArabic ? 'تسجيل الدخول' : 'Log in',
      isLoading: _isLoading,
      onPressed: _handleLogin,
    );
  }

  /// 5. Bottom "Don't have an account? Sign up" prompt
  Widget _buildFooterPrompt() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: _isArabic ? 'ليس لديك حساب؟ ' : "Don't have an account? ",
          style: const TextStyle(
            color: Color(0xFF2B2D42),
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: _isArabic ? 'إنشاء حساب' : 'Sign up',
              style: const TextStyle(
                color: AppColor.primary,
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()..onTap = _navigateToSignUp,
            ),
          ],
        ),
      ),
    );
  }
}
