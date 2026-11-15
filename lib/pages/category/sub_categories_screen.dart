import 'package:flutter/material.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/models/category_model.dart';
import 'package:restaurant/pages/category/category_products_screen.dart';
import 'package:restaurant/widgets/cart_badge_icon.dart';
import 'package:restaurant/widgets/custom_back_button.dart';

/// Clean Architecture Subcategories Screen ("أنواع أطعمة الفئة")
///
/// Faithfully reproduces the user's reference mockup (Image 2):
/// - AppBar with back button and category title (e.g. "مأكولات بحرية")
/// - Vertical list of subcategories
/// - Each row displays: food type icon on the left, name & dish count in the center,
///   and a forward chevron arrow on the right.
class SubCategoriesScreen extends StatelessWidget {
  final FoodCategoryModel category;

  const SubCategoriesScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppLanguage.currentLocale,
      builder: (context, _) {
        final isArabic = AppLanguage.isArabic;
        final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
        final categoryTitle = isArabic ? category.nameAr : category.nameEn;
        final subcategories = category.subcategories;

        return Directionality(
          textDirection: textDirection,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              leading: CustomBackButton(
                onPressed: () => Navigator.of(context).maybePop(),
                isRtl: isArabic,
              ),
              title: Text(
                categoryTitle,
                style: const TextStyle(
                  color: AppColor.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              actions: const [
                CartBadgeIcon(size: 38),
                SizedBox(width: 14),
              ],
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1.0),
                child: Divider(
                  height: 1.0,
                  thickness: 1.0,
                  color: Color(0xFFEEEEEE),
                ),
              ),
            ),
            body: subcategories.isEmpty
                ? _buildEmptyState(isArabic)
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: subcategories.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 2),
                    itemBuilder: (context, index) {
                      final sub = subcategories[index];
                      final title = isArabic ? sub.nameAr : sub.nameEn;

                      return _buildSubCategoryItem(
                        context: context,
                        subCategory: sub,
                        title: title,
                        isArabic: isArabic,
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget _buildSubCategoryItem({
    required BuildContext context,
    required SubCategoryModel subCategory,
    required String title,
    required bool isArabic,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryProductsScreen(
                category: category,
                subCategory: subCategory,
              ),
            ),
          );
        },
        splashColor: AppColor.primary.withValues(alpha: 0.08),
        highlightColor: AppColor.primary.withValues(alpha: 0.04),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          child: Row(
            children: [
              // Food category / subcategory icon
              SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: Image.asset(
                    subCategory.imagePath,
                    width: 42,
                    height: 42,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColor.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.fastfood_rounded,
                        color: AppColor.primary,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 18),

              // Title and count
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${subCategory.count}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              // Forward Chevron Arrow
              Icon(
                isArabic
                    ? CustomBackButton.chevronLeft
                    : CustomBackButton.chevronRight,
                size: 16,
                color: const Color(0xFFBDBDBD),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isArabic) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.restaurant_menu_rounded,
                size: 34,
                color: AppColor.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isArabic ? 'لا توجد أصناف حالياً' : 'No food items available',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColor.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
