import 'package:flutter/material.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/models/category_model.dart';
import 'package:restaurant/models/product_model.dart';
import 'package:restaurant/pages/product/product_detail_screen.dart';
import 'package:restaurant/widgets/cart_badge_icon.dart';
import 'package:restaurant/widgets/custom_back_button.dart';
import 'package:restaurant/widgets/custom_snackbar.dart';

/// Clean Architecture Category Products Screen ("شاشة المنتجات بالفئة المحددة")
///
/// Faithfully reproduces the user's reference mockup (Image 3):
/// - AppBar with back button and subcategory/dish title (e.g. "سمك مشوي")
/// - Vertical list of food products
/// - Each row displays:
///   * Rounded product image on the left
///   * Product title and multi-line description in the center
///   * Favorite heart icon on the right
/// - Tapping an item navigates to the detailed ProductDetailScreen.
class CategoryProductsScreen extends StatefulWidget {
  final FoodCategoryModel? category;
  final SubCategoryModel? subCategory;
  final String? title;
  final List<ProductModel>? products;

  const CategoryProductsScreen({
    super.key,
    this.category,
    this.subCategory,
    this.title,
    this.products,
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  late List<ProductModel> _products;

  @override
  void initState() {
    super.initState();
    if (widget.products != null && widget.products!.isNotEmpty) {
      _products = List.from(widget.products!);
    } else if (widget.subCategory != null &&
        widget.subCategory!.products.isNotEmpty) {
      _products = List.from(widget.subCategory!.products);
    } else {
      // Fallback sample products matching the mockup
      _products = List.from(ProductModel.sampleProducts);
    }
  }

  void _toggleFavorite(int index) {
    final item = _products[index];
    final newStatus = !item.isLiked;

    setState(() {
      _products[index] = item.copyWith(
        isLiked: newStatus,
        likesCount: newStatus ? item.likesCount + 1 : item.likesCount - 1,
      );
    });

    final isArabic = AppLanguage.isArabic;
    final name = isArabic ? _products[index].nameAr : _products[index].nameEn;

    showAppSnackbar(
      context,
      newStatus
          ? (isArabic
              ? 'تمت إضافة "$name" إلى المفضلة ❤️'
              : 'Added "$name" to favorites ❤️')
          : (isArabic
              ? 'تمت إزالة "$name" من المفضلة'
              : 'Removed "$name" from favorites'),
      type: SnackBarType.info,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppLanguage.currentLocale,
      builder: (context, _) {
        final isArabic = AppLanguage.isArabic;
        final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

        // Determine title matching the subcategory or category
        final screenTitle = widget.title ??
            (widget.subCategory != null
                ? (isArabic
                    ? widget.subCategory!.nameAr
                    : widget.subCategory!.nameEn)
                : (widget.category != null
                    ? (isArabic
                        ? widget.category!.nameAr
                        : widget.category!.nameEn)
                    : (isArabic ? 'المنتجات' : 'Products')));

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
                screenTitle,
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
            body: _products.isEmpty
                ? _buildEmptyState(isArabic)
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    itemCount: _products.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return _buildProductItem(
                        context: context,
                        product: product,
                        index: index,
                        isArabic: isArabic,
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget _buildProductItem({
    required BuildContext context,
    required ProductModel product,
    required int index,
    required bool isArabic,
  }) {
    // In reference Image 3:
    // Left: Rounded image of dish
    // Middle: "product3", multi-line description "desc product1 desc product1..."
    // Right: Heart icon
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        splashColor: AppColor.primary.withValues(alpha: 0.08),
        highlightColor: AppColor.primary.withValues(alpha: 0.04),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFF0F0F0),
              width: 1.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image (Rounded rectangle with radius ~16)
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 78,
                  height: 78,
                  child: Image.asset(
                    product.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: const Color(0xFFF0F0F0),
                      child: const Icon(
                        Icons.fastfood_rounded,
                        color: AppColor.textMuted,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // Title & Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isArabic ? product.nameAr : product.nameEn,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      isArabic
                          ? product.descriptionAr
                          : product.descriptionEn,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textMuted,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          '${product.price.toStringAsFixed(product.price.truncateToDouble() == product.price ? 0 : 2)} ${isArabic ? 'ر.س' : 'SAR'}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColor.primary,
                          ),
                        ),
                        if (product.oldPrice != null) ...[
                          const SizedBox(width: 6),
                          Text(
                            '${product.oldPrice!.toStringAsFixed(0)} ${isArabic ? 'ر.س' : 'SAR'}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textMuted,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Favorite Heart Icon Button
              IconButton(
                onPressed: () => _toggleFavorite(index),
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    product.isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    key: ValueKey<bool>(product.isLiked),
                    color: product.isLiked
                        ? AppColor.primary
                        : const Color(0xFF4A4A4A),
                    size: 24,
                  ),
                ),
                splashRadius: 22,
                tooltip: isArabic ? 'إضافة إلى المفضلة' : 'Favorite',
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
                Icons.no_meals_rounded,
                size: 34,
                color: AppColor.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isArabic ? 'لا توجد منتجات متاحة' : 'No products available',
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
