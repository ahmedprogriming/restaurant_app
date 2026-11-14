import 'package:flutter/material.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/core/user_state.dart';
import 'package:restaurant/models/user_model.dart';
import 'package:restaurant/routers/app_routes.dart';

/// Clean Architecture User Account Drawer
///
/// Faithfully reproduces the reference screenshot:
/// - Coral circular avatar with white user icon
/// - User Name ("Thaer") and Email ("thaer@gmail.com")
/// - Divider lines
/// - Menu items with brand-colored icons on the right, label in the center,
///   and chevron arrow `<` on the left (in RTL).
class UserAccountDrawer extends StatelessWidget {
  /// Callback when home is selected
  final VoidCallback? onHomeSelected;

  /// Callback when favorites is selected
  final VoidCallback? onFavoritesSelected;

  /// Callback when account is selected
  final VoidCallback? onAccountSelected;

  const UserAccountDrawer({
    super.key,
    this.onHomeSelected,
    this.onFavoritesSelected,
    this.onAccountSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = AppLanguage.isArabic;
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: textDirection,
      child: Drawer(
        // Drawer takes ~74% of the screen width, matching the reference image mockup
        width: (screenWidth * 0.74).clamp(280.0, 360.0),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: SafeArea(
          child: ValueListenableBuilder<UserModel>(
            valueListenable: UserState.currentUser,
            builder: (context, user, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),

                  // User Avatar & Info Header (Centered as in reference mockup)
                  _buildHeader(context, user, isArabic),

                  const SizedBox(height: 26),

                  // Menu Items with Dividers
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF0F0F0),
                        ),

                        // 1. الصفحة الرئيسية (Home Page)
                        _buildDrawerItem(
                          context: context,
                          title: isArabic ? 'الصفحة الرئيسية' : 'Home Page',
                          icon: Icons.home_rounded,
                          onTap: () {
                            Navigator.pop(context); // Close drawer
                            if (onHomeSelected != null) {
                              onHomeSelected!();
                            } else {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.home,
                                (route) => false,
                              );
                            }
                          },
                          isArabic: isArabic,
                        ),

                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF0F0F0),
                        ),

                        // 2. حسابي (My Account)
                        _buildDrawerItem(
                          context: context,
                          title: isArabic ? 'حسابي' : 'My Account',
                          icon: Icons.person_rounded,
                          onTap: () {
                            Navigator.pop(context); // Close drawer
                            if (onAccountSelected != null) {
                              onAccountSelected!();
                            } else {
                              Navigator.pushNamed(context, AppRoutes.account);
                            }
                          },
                          isArabic: isArabic,
                        ),

                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF0F0F0),
                        ),

                        // 3. مفضلاتي (My Favorites)
                        _buildDrawerItem(
                          context: context,
                          title: isArabic ? 'مفضلاتي' : 'My Favorites',
                          icon: Icons.favorite_rounded,
                          onTap: () {
                            Navigator.pop(context); // Close drawer
                            if (onFavoritesSelected != null) {
                              onFavoritesSelected!();
                            } else {
                              Navigator.pushNamed(context, AppRoutes.favorites);
                            }
                          },
                          isArabic: isArabic,
                        ),

                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF0F0F0),
                        ),

                        // 4. سلة التسوق (Shopping Cart)
                        _buildDrawerItem(
                          context: context,
                          title: isArabic ? 'سلة التسوق' : 'Shopping Cart',
                          icon: Icons.shopping_bag_rounded,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, AppRoutes.cart);
                          },
                          isArabic: isArabic,
                        ),

                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF0F0F0),
                        ),

                        // Additional Clean Action Items (Notifications, Orders, Language)
                        _buildDrawerItem(
                          context: context,
                          title: isArabic ? 'الإشعارات' : 'Notifications',
                          icon: Icons.notifications_rounded,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, AppRoutes.notifications);
                          },
                          isArabic: isArabic,
                        ),

                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF0F0F0),
                        ),

                        _buildDrawerItem(
                          context: context,
                          title: isArabic ? 'تغيير اللغة (English)' : 'Change Language (العربية)',
                          icon: Icons.language_rounded,
                          onTap: () {
                            AppLanguage.toggleLanguage();
                          },
                          isArabic: isArabic,
                        ),

                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF0F0F0),
                        ),
                      ],
                    ),
                  ),

                  // Bottom Logout Action
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: InkWell(
                      onTap: () => _confirmLogout(context, isArabic),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.logout_rounded,
                              size: 18,
                              color: Color(0xFFE63946),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isArabic ? 'تسجيل الخروج' : 'Log Out',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFE63946),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Builds the top Profile Header matching the reference screenshot
  Widget _buildHeader(BuildContext context, UserModel user, bool isArabic) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRoutes.account);
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Coral circular avatar with white person silhouette
            Container(
              width: 76,
              height: 76,
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
                  size: 42,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // User Name
            Text(
              user.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF222222),
                letterSpacing: -0.2,
              ),
            ),

            const SizedBox(height: 4),

            // User Email
            Text(
              user.email,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8D99AE),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a single Menu Tile matching the reference screenshot
  Widget _buildDrawerItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required bool isArabic,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColor.primary.withValues(alpha: 0.08),
        highlightColor: AppColor.primary.withValues(alpha: 0.04),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              // Trailing chevron arrow pointing left in Arabic (or right in English)
              Icon(
                isArabic ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
                size: 20,
                color: const Color(0xFF6C757D),
              ),

              const SizedBox(width: 8),

              // Title in Center
              Expanded(
                child: Text(
                  title,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2B2D42),
                    letterSpacing: -0.2,
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // Right Icon in RTL / Brand Colored Icon
              Icon(
                icon,
                size: 22,
                color: AppColor.primary,
              ),
            ],
          ),
        ),
      ),
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
                  Navigator.pop(ctx); // Close dialog
                  Navigator.pop(context); // Close drawer
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
