import 'package:flutter/material.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/core/user_state.dart';
import 'package:restaurant/models/user_model.dart';
import 'package:restaurant/routers/app_routes.dart';
import 'package:restaurant/widgets/custom_back_button.dart';
import 'package:restaurant/widgets/custom_primary_button.dart';
import 'package:restaurant/widgets/custom_rounded_text_field.dart';
import 'package:restaurant/widgets/custom_snackbar.dart';

/// Full User Account / Profile Screen ("شاشة حساب المستخدم")
///
/// Implements Clean Architecture & Clean Code principles:
/// - Reactive user state via [UserState]
/// - Personal information review and inline modal editing
/// - Quick account statistics (Orders, Favorites, Wallet)
/// - Clean categorized settings cards
/// - Full RTL (Arabic) & LTR (English) support
class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppLanguage.currentLocale,
      builder: (context, _) {
        final isArabic = AppLanguage.isArabic;
        final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

        return Directionality(
          textDirection: textDirection,
          child: Scaffold(
            backgroundColor: const Color(0xFFF8F9FA),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              leading: CustomBackButton(
                onPressed: () => Navigator.pop(context),
                isRtl: isArabic,
              ),
              title: Text(
                isArabic ? 'حسابي' : 'My Account',
                style: const TextStyle(
                  color: AppColor.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  tooltip: isArabic ? 'تغيير اللغة' : 'Change Language',
                  icon: const Icon(Icons.language_rounded, color: AppColor.primary),
                  onPressed: () => AppLanguage.toggleLanguage(),
                ),
              ],
            ),
            body: ValueListenableBuilder<UserModel>(
              valueListenable: UserState.currentUser,
              builder: (context, user, _) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      // 1. Profile Avatar & Primary Info Card
                      _buildProfileCard(context, user, isArabic),

                      const SizedBox(height: 16),

                      // 2. Account Quick Stats
                      _buildQuickStats(context, user, isArabic),

                      const SizedBox(height: 20),

                      // 3. Personal Information Section
                      _buildSectionHeader(
                        isArabic ? 'المعلومات الشخصية' : 'Personal Information',
                        isArabic,
                      ),
                      const SizedBox(height: 10),
                      _buildCardContainer([
                        _buildInfoTile(
                          icon: Icons.person_outline_rounded,
                          label: isArabic ? 'الاسم الكامل' : 'Full Name',
                          value: user.name,
                          onTap: () => _openEditProfileDialog(context, user, isArabic),
                          isArabic: isArabic,
                        ),
                        const Divider(height: 1, indent: 56, color: Color(0xFFF0F0F0)),
                        _buildInfoTile(
                          icon: Icons.email_outlined,
                          label: isArabic ? 'البريد الإلكتروني' : 'Email Address',
                          value: user.email,
                          onTap: () => _openEditProfileDialog(context, user, isArabic),
                          isArabic: isArabic,
                        ),
                        const Divider(height: 1, indent: 56, color: Color(0xFFF0F0F0)),
                        _buildInfoTile(
                          icon: Icons.phone_outlined,
                          label: isArabic ? 'رقم الهاتف' : 'Phone Number',
                          value: user.phone,
                          onTap: () => _openEditProfileDialog(context, user, isArabic),
                          isArabic: isArabic,
                        ),
                        const Divider(height: 1, indent: 56, color: Color(0xFFF0F0F0)),
                        _buildInfoTile(
                          icon: Icons.location_on_outlined,
                          label: isArabic ? 'عنوان التوصيل' : 'Delivery Address',
                          value: user.address,
                          onTap: () => _openEditProfileDialog(context, user, isArabic),
                          isArabic: isArabic,
                        ),
                      ]),

                      const SizedBox(height: 20),

                      // 4. Activity & Orders Section
                      _buildSectionHeader(
                        isArabic ? 'النشاط والطلبات' : 'Activity & Orders',
                        isArabic,
                      ),
                      const SizedBox(height: 10),
                      _buildCardContainer([
                        _buildActionTile(
                          icon: Icons.receipt_long_rounded,
                          title: isArabic ? 'طلباتي السابقة' : 'My Orders',
                          subtitle: isArabic ? '${user.totalOrders} طلب سابق' : '${user.totalOrders} completed orders',
                          onTap: () {
                            showAppSnackbar(
                              context,
                              isArabic ? 'قائمة الطلبات السابقة' : 'Orders list',
                              type: SnackBarType.info,
                            );
                          },
                          isArabic: isArabic,
                        ),
                        const Divider(height: 1, indent: 56, color: Color(0xFFF0F0F0)),
                        _buildActionTile(
                          icon: Icons.favorite_rounded,
                          title: isArabic ? 'مفضلاتي' : 'My Favorites',
                          subtitle: isArabic ? '${user.favoriteCount} أطباق ومطاعم' : '${user.favoriteCount} favorite items',
                          onTap: () => Navigator.pushNamed(context, AppRoutes.favorites),
                          isArabic: isArabic,
                        ),
                        const Divider(height: 1, indent: 56, color: Color(0xFFF0F0F0)),
                        _buildActionTile(
                          icon: Icons.notifications_outlined,
                          title: isArabic ? 'الإشعارات والعروض' : 'Notifications & Alerts',
                          subtitle: isArabic ? 'عروض حصرية وخصومات' : 'Exclusive deals & updates',
                          onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
                          isArabic: isArabic,
                        ),
                      ]),

                      const SizedBox(height: 20),

                      // 5. Preferences & App Settings
                      _buildSectionHeader(
                        isArabic ? 'الإعدادات والتفضيلات' : 'Preferences & Settings',
                        isArabic,
                      ),
                      const SizedBox(height: 10),
                      _buildCardContainer([
                        _buildSwitchTile(
                          icon: Icons.notifications_active_outlined,
                          title: isArabic ? 'تنبيهات الطلبات' : 'Order Notifications',
                          value: user.notificationsEnabled,
                          onChanged: (val) {
                            UserState.setNotificationsEnabled(val);
                            showAppSnackbar(
                              context,
                              val
                                  ? (isArabic ? 'تم تفعيل الإشعارات' : 'Notifications enabled')
                                  : (isArabic ? 'تم تعطيل الإشعارات' : 'Notifications disabled'),
                              type: SnackBarType.info,
                            );
                          },
                          isArabic: isArabic,
                        ),
                        const Divider(height: 1, indent: 56, color: Color(0xFFF0F0F0)),
                        _buildActionTile(
                          icon: Icons.translate_rounded,
                          title: isArabic ? 'لغة التطبيق' : 'Application Language',
                          subtitle: isArabic ? 'العربية (الحالية)' : 'English (Current)',
                          trailingText: isArabic ? 'تغيير' : 'Switch',
                          onTap: () => AppLanguage.toggleLanguage(),
                          isArabic: isArabic,
                        ),
                      ]),

                      const SizedBox(height: 20),

                      // 6. Support & Security
                      _buildSectionHeader(
                        isArabic ? 'الدعم والمساعدة' : 'Support & Legal',
                        isArabic,
                      ),
                      const SizedBox(height: 10),
                      _buildCardContainer([
                        _buildActionTile(
                          icon: Icons.help_outline_rounded,
                          title: isArabic ? 'مركز المساعدة والدعم' : 'Help & Support Center',
                          onTap: () {
                            showAppSnackbar(
                              context,
                              isArabic ? 'تواصل مع فريق الدعم 24/7' : 'Contact Support 24/7',
                              type: SnackBarType.info,
                            );
                          },
                          isArabic: isArabic,
                        ),
                        const Divider(height: 1, indent: 56, color: Color(0xFFF0F0F0)),
                        _buildActionTile(
                          icon: Icons.privacy_tip_outlined,
                          title: isArabic ? 'سياسة الخصوصية والشروط' : 'Privacy Policy & Terms',
                          onTap: () {
                            showAppSnackbar(
                              context,
                              isArabic ? 'شروط الخدمة والخصوصية' : 'Terms & Privacy',
                              type: SnackBarType.info,
                            );
                          },
                          isArabic: isArabic,
                        ),
                      ]),

                      const SizedBox(height: 28),

                      // 7. Logout Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () => _confirmLogout(context, isArabic),
                          icon: const Icon(Icons.logout_rounded, color: Color(0xFFE63946)),
                          label: Text(
                            isArabic ? 'تسجيل الخروج' : 'Log Out',
                            style: const TextStyle(
                              color: Color(0xFFE63946),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFFFCDD2), width: 1.2),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  /// Profile Card at top
  Widget _buildProfileCard(BuildContext context, UserModel user, bool isArabic) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Coral avatar with white person silhouette (matching screenshot)
          Stack(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33F55B61),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: isArabic ? null : 0,
                left: isArabic ? 0 : null,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColor.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // User details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: AppColor.textDark,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColor.accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        user.memberTier,
                        style: const TextStyle(
                          color: Color(0xFFD48B00),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColor.textMuted,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => _openEditProfileDialog(context, user, isArabic),
                  borderRadius: BorderRadius.circular(6),
                  child: Text(
                    isArabic ? 'تعديل الملف الشخصي ✏️' : 'Edit Profile ✏️',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Quick Stats Summary
  Widget _buildQuickStats(BuildContext context, UserModel user, bool isArabic) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            label: isArabic ? 'الطلبات' : 'Orders',
            value: '${user.totalOrders}',
            icon: Icons.shopping_bag_outlined,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatItem(
            label: isArabic ? 'المفضلة' : 'Favorites',
            value: '${user.favoriteCount}',
            icon: Icons.favorite_border_rounded,
            onTap: () => Navigator.pushNamed(context, AppRoutes.favorites),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatItem(
            label: isArabic ? 'المحفظة' : 'Wallet',
            value: '${user.walletBalance.toStringAsFixed(0)} ${isArabic ? "ر.س" : "SAR"}',
            icon: Icons.account_balance_wallet_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColor.primary, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColor.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: AppColor.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isArabic) {
    return Align(
      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w700,
          color: Color(0xFF6C757D),
        ),
      ),
    );
  }

  Widget _buildCardContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    required bool isArabic,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColor.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: AppColor.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textDark,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.edit_outlined,
              size: 16,
              color: Color(0xFFB0B7C3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    String? subtitle,
    String? trailingText,
    required VoidCallback onTap,
    required bool isArabic,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColor.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textDark,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: AppColor.textMuted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailingText != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  trailingText,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary,
                  ),
                ),
              ),
            Icon(
              isArabic ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
              size: 18,
              color: const Color(0xFFB0B7C3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isArabic,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColor.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColor.primary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.textDark,
              ),
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: AppColor.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  /// Open Modal to edit user details
  void _openEditProfileDialog(BuildContext context, UserModel user, bool isArabic) {
    final nameCtrl = TextEditingController(text: user.name);
    final emailCtrl = TextEditingController(text: user.email);
    final phoneCtrl = TextEditingController(text: user.phone);
    final addressCtrl = TextEditingController(text: user.address);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isArabic ? 'تعديل البيانات الشخصية' : 'Edit Profile Information',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColor.textDark,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomRoundedTextField(
                    hintText: isArabic ? 'الاسم الكامل' : 'Full Name',
                    controller: nameCtrl,
                    prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColor.primary),
                  ),
                  const SizedBox(height: 12),
                  CustomRoundedTextField(
                    hintText: isArabic ? 'البريد الإلكتروني' : 'Email Address',
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined, color: AppColor.primary),
                  ),
                  const SizedBox(height: 12),
                  CustomRoundedTextField(
                    hintText: isArabic ? 'رقم الهاتف' : 'Phone Number',
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    prefixIcon: const Icon(Icons.phone_outlined, color: AppColor.primary),
                  ),
                  const SizedBox(height: 12),
                  CustomRoundedTextField(
                    hintText: isArabic ? 'عنوان التوصيل' : 'Delivery Address',
                    controller: addressCtrl,
                    prefixIcon: const Icon(Icons.location_on_outlined, color: AppColor.primary),
                  ),
                  const SizedBox(height: 20),
                  CustomPrimaryButton(
                    text: isArabic ? 'حفظ التعديلات' : 'Save Changes',
                    onPressed: () {
                      if (nameCtrl.text.trim().isEmpty) {
                        showAppSnackbar(
                          context,
                          isArabic ? 'يرجى إدخال الاسم' : 'Please enter name',
                          type: SnackBarType.error,
                        );
                        return;
                      }
                      UserState.updateProfile(
                        name: nameCtrl.text.trim(),
                        email: emailCtrl.text.trim(),
                        phone: phoneCtrl.text.trim(),
                        address: addressCtrl.text.trim(),
                      );
                      Navigator.pop(ctx);
                      showAppSnackbar(
                        context,
                        isArabic ? 'تم حفظ التعديلات بنجاح' : 'Changes saved successfully',
                        type: SnackBarType.success,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Clean Logout Confirmation Dialog
  void _confirmLogout(BuildContext context, bool isArabic) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              isArabic ? 'تسجيل الخروج' : 'Log Out',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.textDark,
              ),
            ),
            content: Text(
              isArabic
                  ? 'هل أنت متأكد من رغبتك في تسجيل الخروج من الحساب؟'
                  : 'Are you sure you want to log out of your account?',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6C757D),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  isArabic ? 'إلغاء' : 'Cancel',
                  style: const TextStyle(
                    color: Color(0xFF6C757D),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  UserState.logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE63946),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  isArabic ? 'تأكيد الخروج' : 'Confirm',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
