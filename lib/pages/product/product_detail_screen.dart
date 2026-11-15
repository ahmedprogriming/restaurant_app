import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/cart_state.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/models/product_model.dart';
import 'package:restaurant/routers/app_routes.dart';
import 'package:restaurant/widgets/cart_badge_icon.dart';
import 'package:restaurant/widgets/custom_back_button.dart';
import 'package:restaurant/widgets/custom_snackbar.dart';

/// Clean Architecture Product Detail Screen faithfully implementing
/// the reference mockups (Strawberry & Grilled Salmon / سمك مشوي).
class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late ProductModel _product;
  int _quantity = 1;
  late bool _isLiked;
  late int _likesCount;
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
    _isLiked = _product.isLiked;
    _likesCount = _product.likesCount;

    // Check if item already exists in cart, otherwise start at 1
    final existingQty = CartState.getQuantity(_product.id);
    _quantity = existingQty > 0 ? existingQty : 1;

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    HapticFeedback.lightImpact();
    setState(() {
      _quantity++;
    });
    _animController.forward(from: 0.92);
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      HapticFeedback.lightImpact();
      setState(() {
        _quantity--;
      });
      _animController.forward(from: 0.92);
    }
  }

  void _toggleLike() {
    HapticFeedback.selectionClick();
    setState(() {
      _isLiked = !_isLiked;
      _likesCount += _isLiked ? 1 : -1;
    });
  }

  void _addToCart(bool isArabic) {
    HapticFeedback.mediumImpact();
    CartState.addItem(_product, quantity: _quantity);

    showAppSnackbar(
      context,
      isArabic
          ? 'تمت إضافة ($_quantity) من ${_product.nameAr} إلى السلة 🛍️'
          : 'Added ($_quantity) ${_product.nameEn} to Cart 🛍️',
      type: SnackBarType.success,
      actionLabel: isArabic ? 'عرض السلة' : 'View Cart',
      onAction: () {
        Navigator.pushNamed(context, AppRoutes.cart);
      },
    );
  }

  void _showVideoDialog(bool isArabic) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isArabic ? 'طريقة التحضير والمصدر' : 'Preparation & Story',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        _product.imagePath,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withValues(alpha: 0.35),
                      ),
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: AppColor.primary,
                            size: 38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                isArabic
                  ? 'فيديو حصري يوضح كيفية اختيار المكونات الطازجة وتحضير الطبق وفق أعلى معايير الجودة الغذائية.'
                  : 'Exclusive video showing how fresh ingredients are curated and prepared to perfection.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(ctx),
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: Text(isArabic ? 'حسناً، فهمت' : 'Got it'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppLanguage.currentLocale,
      builder: (context, _) {
        final isArabic = AppLanguage.isArabic;
        final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
        final name = isArabic ? _product.nameAr : _product.nameEn;
        final description =
            isArabic ? _product.descriptionAr : _product.descriptionEn;
        final deliveryTime =
            isArabic ? _product.deliveryTimeAr : _product.deliveryTimeEn;
        final unit = isArabic ? _product.unitAr : _product.unitEn;

        // Dynamic price calculation based on quantity
        final totalPrice = _product.price * _quantity;
        final formattedPrice = isArabic
            ? '${totalPrice.toStringAsFixed(totalPrice.truncateToDouble() == totalPrice ? 0 : 2)} ر.س'
            : '\$ ${totalPrice.toStringAsFixed(2)}';

        return Directionality(
          textDirection: textDirection,
          child: Scaffold(
            backgroundColor: const Color(0xFFFBFBFB),
            body: SafeArea(
              child: Stack(
                children: [
                  // Main Scrollable Content
                  CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      // Top App Bar with back, title/heart, and cart icon
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 12.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Floating Back Button matching language logic
                              _buildFloatingButton(
                                icon: isArabic
                                    ? CustomBackButton.chevronRight
                                    : CustomBackButton.chevronLeft,
                                iconColor: AppColor.primary,
                                onTap: () => Navigator.pop(context),
                              ),

                              // Actions: Favorite + Cart
                              Row(
                                children: [
                                  _buildFloatingButton(
                                    icon: _isLiked
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_outline_rounded,
                                    iconColor: _isLiked
                                        ? AppColor.primary
                                        : AppColor.textMuted,
                                    onTap: _toggleLike,
                                  ),
                                  const SizedBox(width: 12),
                                  const CartBadgeIcon(
                                    size: 46,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Hero Product Image Card with floating Quantity Selector
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomCenter,
                            children: [
                              // Image Card Container matching Image 1 & 2
                              Container(
                                height: 290,
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(32),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(32),
                                  child: Hero(
                                    tag: 'product_image_${_product.id}',
                                    child: Image.asset(
                                      _product.imagePath,
                                      fit: BoxFit.cover,
                                      errorBuilder: (ctx, err, stack) =>
                                          Container(
                                        color: Colors.grey.shade100,
                                        child: const Center(
                                          child: Icon(
                                            Icons.restaurant_rounded,
                                            size: 64,
                                            color: AppColor.textMuted,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Floating Quantity Selector overlapping the image
                              // Exact visual representation from both mockups:
                              // Coral rounded [-] button, central quantity, Coral rounded [+] button
                              Positioned(
                                bottom: 6,
                                child: ScaleTransition(
                                  scale: _scaleAnimation,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.primary
                                              .withValues(alpha: 0.18),
                                          blurRadius: 16,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Minus Button
                                        _buildQuantityButton(
                                          icon: Icons.remove_rounded,
                                          onTap: _decrementQuantity,
                                        ),

                                        // Quantity Display with unit
                                        Container(
                                          constraints:
                                              const BoxConstraints(minWidth: 50),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                          ),
                                          child: Text(
                                            unit == 'item' || unit == 'وجبة'
                                                ? '$_quantity'
                                                : '$_quantity $unit',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.textDark,
                                            ),
                                          ),
                                        ),

                                        // Plus Button
                                        _buildQuantityButton(
                                          icon: Icons.add_rounded,
                                          onTap: _incrementQuantity,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Product Details Info Section
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(22, 16, 22, 110),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Title
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.textDark,
                                  letterSpacing: -0.3,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Metadata Badges Row: Calories, Rating & Reviews, Likes
                              Wrap(
                                spacing: 12,
                                runSpacing: 8,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  // Calories Badge (Image 2)
                                  _buildBadge(
                                    icon: '🔥',
                                    label: isArabic
                                        ? '${_product.calories} سعرة حرارية'
                                        : '${_product.calories} calories',
                                    backgroundColor: const Color(0xFFFFF4EE),
                                    textColor: const Color(0xFFE76F51),
                                  ),

                                  // Rating & Review Badge (Image 1 & 2)
                                  _buildBadge(
                                    icon: '⭐',
                                    label: isArabic
                                        ? '${_product.rating} (${_product.reviewCount} تقييم)'
                                        : '${_product.rating} (${_product.reviewCount} review)',
                                    backgroundColor: const Color(0xFFFFF9E6),
                                    textColor: const Color(0xFFB78103),
                                  ),

                                  // Likes Count (Image 1)
                                  _buildBadge(
                                    icon: '❤️',
                                    label: '$_likesCount',
                                    backgroundColor: const Color(0xFFFFECEF),
                                    textColor: AppColor.primary,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Description text matching clean typography
                              Text(
                                description,
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  height: 1.65,
                                  color: Color(0xFF6C757D),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Delivery Time & Video Button (matching Image 2)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Delivery Time Card
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isArabic
                                            ? 'وقت التوصيل'
                                            : 'Delivery time',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.textDark,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Text(
                                            '⏰ ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            deliveryTime,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF5A6275),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Watch Video Button (Image 2)
                                  InkWell(
                                    onTap: () => _showVideoDialog(isArabic),
                                    borderRadius: BorderRadius.circular(24),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 1.2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.04),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 26,
                                            height: 26,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFFF9F1C),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.play_arrow_rounded,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            isArabic
                                                ? 'مشاهدة الفيديو'
                                                : 'Watch video',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
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
                        ),
                      ),
                    ],
                  ),

                  // Bottom Sticky Capsule Action Bar matching Image 1 & 2
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFF55B61),
                            Color(0xFFFF7278),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(34),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primary.withValues(alpha: 0.40),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price in bold white font
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (child, anim) =>
                                    FadeTransition(opacity: anim, child: child),
                                child: Text(
                                  formattedPrice,
                                  key: ValueKey<String>(formattedPrice),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Pill Button: "إضافة الى السلة" / "Add to Cart"
                          Material(
                            color: Colors.white.withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(26),
                            child: InkWell(
                              onTap: () => _addToCart(isArabic),
                              borderRadius: BorderRadius.circular(26),
                              splashColor: Colors.white.withValues(alpha: 0.3),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.shopping_bag_rounded,
                                      color: Colors.white,
                                      size: 19,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      isArabic
                                          ? 'إضافة إلى السلة'
                                          : 'Add to Cart',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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

  /// Helper for top circular floating action buttons
  Widget _buildFloatingButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 46,
          height: 46,
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  /// Helper for rounded orange/coral quantity stepper buttons
  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColor.primary,
      borderRadius: BorderRadius.circular(14),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 36,
          height: 36,
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  /// Helper for information tag badges
  Widget _buildBadge({
    required String icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
