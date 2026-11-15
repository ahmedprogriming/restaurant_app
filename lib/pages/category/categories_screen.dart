import 'package:flutter/material.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/models/category_model.dart';
import 'package:restaurant/pages/category/sub_categories_screen.dart';
import 'package:restaurant/widgets/cart_badge_icon.dart';
import 'package:restaurant/widgets/custom_back_button.dart';

/// Clean Architecture Food Categories Screen ("قائمة المأكولات")
///
/// Faithfully reproduces the user's reference mockup:
/// - AppBar with back button and title "قائمة المأكولات"
/// - List of food categories
/// - Each row has a soft pink/peach circular avatar containing the category icon,
///   the category name, and a forward chevron arrow indicator.
class CategoriesScreen extends StatefulWidget {
  final List<FoodCategoryModel>? categories;

  const CategoriesScreen({
    super.key,
    this.categories,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late final List<FoodCategoryModel> _categories =
      widget.categories ?? FoodCategoryModel.sampleCategories;

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
                isArabic ? 'قائمة المأكولات' : 'Food Categories',
                style: const TextStyle(
                  color: AppColor.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
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
            body: SafeArea(
              top: false,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 2),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final title = isArabic ? cat.nameAr : cat.nameEn;

                  return _buildCategoryItem(
                    context: context,
                    category: cat,
                    title: title,
                    isArabic: isArabic,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem({
    required BuildContext context,
    required FoodCategoryModel category,
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
              builder: (_) => SubCategoriesScreen(category: category),
            ),
          );
        },
        splashColor: AppColor.primary.withValues(alpha: 0.08),
        highlightColor: AppColor.primary.withValues(alpha: 0.04),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Row(
            children: [
              // Circular avatar with soft pink/peach background
              Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFECEB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      category.imagePath,
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.restaurant_rounded,
                        color: AppColor.primary,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 18),

              // Category Title
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textDark,
                  ),
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
}
