import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/cart_state.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/models/cart_item_model.dart';
import 'package:restaurant/routers/app_routes.dart';
import 'package:restaurant/widgets/custom_back_button.dart';
import 'package:restaurant/widgets/custom_snackbar.dart';

/// Clean Architecture Shopping Cart Screen ("سلة التسوق")
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoController = TextEditingController();
  bool _isCheckingOut = false;

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _applyPromo(bool isArabic) {
    final code = _promoController.text.trim();
    if (code.isEmpty) return;

    final success = CartState.applyPromoCode(code);
    FocusScope.of(context).unfocus();

    if (success) {
      showAppSnackbar(
        context,
        isArabic
            ? 'تم تطبيق كود الخصم ($code) بنجاح 🎉'
            : 'Promo code ($code) applied successfully 🎉',
        type: SnackBarType.success,
      );
    } else {
      showAppSnackbar(
        context,
        isArabic
            ? 'كود الخصم غير صالح. جرب: SAVE20 أو MEAL10'
            : 'Invalid promo code. Try: SAVE20 or MEAL10',
        type: SnackBarType.error,
      );
    }
  }

  void _showClearConfirmDialog(bool isArabic) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          isArabic ? 'تفريغ سلة المشتريات؟' : 'Clear Shopping Cart?',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          isArabic
              ? 'هل أنت متأكد من رغبتك في حذف جميع العناصر من السلة؟'
              : 'Are you sure you want to remove all items from your cart?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              isArabic ? 'إلغاء' : 'Cancel',
              style: const TextStyle(color: AppColor.textMuted),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              CartState.clearCart();
              Navigator.pop(ctx);
              showAppSnackbar(
                context,
                isArabic ? 'تم تفريغ السلة' : 'Cart cleared',
                type: SnackBarType.info,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(isArabic ? 'نعم، تفريغ' : 'Yes, Clear'),
          ),
        ],
      ),
    );
  }

  void _processCheckout(bool isArabic) async {
    setState(() {
      _isCheckingOut = true;
    });

    HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;
    setState(() {
      _isCheckingOut = false;
    });

    // Show Success Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: AppColor.primary,
                    size: 48,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isArabic ? 'تم تأكيد طلبك بنجاح!' : 'Order Placed Successfully!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textDark,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                isArabic
                    ? 'رقم الطلب #WH-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}\nجاري تحضير وجبتك اللذيذة وستصلك خلال 20-30 دقيقة.'
                    : 'Order #WH-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}\nYour delicious food is being prepared and will arrive in 20-30 mins.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColor.textMuted,
                ),
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    CartState.clearCart();
                    Navigator.pop(ctx); // Close dialog
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.home,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                  ),
                  child: Text(
                    isArabic ? 'العودة للرئيسية' : 'Back to Home',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            backgroundColor: const Color(0xFFFBFBFB),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              leading: CustomBackButton(
                onPressed: () => Navigator.pop(context),
                isRtl: isArabic,
              ),
              title: ValueListenableBuilder<List<CartItemModel>>(
                valueListenable: CartState.itemsNotifier,
                builder: (context, items, _) {
                  return Text(
                    isArabic
                        ? 'سلة التسوق (${CartState.totalCount})'
                        : 'Shopping Cart (${CartState.totalCount})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColor.textDark,
                    ),
                  );
                },
              ),
              centerTitle: true,
              actions: [
                ValueListenableBuilder<List<CartItemModel>>(
                  valueListenable: CartState.itemsNotifier,
                  builder: (context, items, _) {
                    if (items.isEmpty) return const SizedBox.shrink();
                    return IconButton(
                      icon: const Icon(
                        Icons.delete_sweep_outlined,
                        color: AppColor.textMuted,
                      ),
                      tooltip: isArabic ? 'تفريغ السلة' : 'Clear Cart',
                      onPressed: () => _showClearConfirmDialog(isArabic),
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: ValueListenableBuilder<List<CartItemModel>>(
              valueListenable: CartState.itemsNotifier,
              builder: (context, items, _) {
                if (items.isEmpty) {
                  return _buildEmptyCart(isArabic);
                }
                return _buildCartList(items, isArabic);
              },
            ),
            bottomNavigationBar: ValueListenableBuilder<List<CartItemModel>>(
              valueListenable: CartState.itemsNotifier,
              builder: (context, items, _) {
                if (items.isEmpty) return const SizedBox.shrink();
                return _buildCheckoutBar(isArabic);
              },
            ),
          ),
        );
      },
    );
  }

  /// Empty Cart View
  Widget _buildEmptyCart(bool isArabic) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 56,
                  color: AppColor.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isArabic ? 'سلة التسوق فارغة' : 'Your Cart is Empty',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColor.textDark,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              isArabic
                  ? 'يبدو أنك لم تقم بإضافة أي وجبات أو منتجات بعد.\nتصفح قائمة الطعام واختر ما يحلو لك!'
                  : 'Looks like you have not added anything yet.\nExplore our delicious menu and find something tasty!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.5,
                color: AppColor.textMuted,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.restaurant_menu_rounded, size: 20),
                label: Text(isArabic ? 'تصفح القائمة' : 'Explore Menu'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Active Cart Items & Details
  Widget _buildCartList(List<CartItemModel> items, bool isArabic) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Delivery Address Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.location_on_rounded,
                      color: AppColor.primary,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isArabic ? 'عنوان التوصيل' : 'Delivery Address',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isArabic ? 'شارع الملك فهد، حي النرجس' : 'King Fahd Rd, Al Narjis',
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: AppColor.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    isArabic ? 'تغيير' : 'Change',
                    style: const TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Items Label
          Text(
            isArabic ? 'عناصر الطلب' : 'Order Items',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColor.textDark,
            ),
          ),

          const SizedBox(height: 12),

          // Cart Items List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildCartItemCard(item, isArabic);
            },
          ),

          const SizedBox(height: 24),

          // Promo Code Voucher Card
          _buildPromoSection(isArabic),

          const SizedBox(height: 24),

          // Bill Summary
          _buildBillSummary(isArabic),
        ],
      ),
    );
  }

  /// Individual item card in the shopping cart
  Widget _buildCartItemCard(CartItemModel item, bool isArabic) {
    final title = isArabic ? item.product.nameAr : item.product.nameEn;
    final unit = isArabic ? item.product.unitAr : item.product.unitEn;
    final itemTotal = item.totalPrice;
    final formattedTotal = isArabic
        ? '${itemTotal.toStringAsFixed(itemTotal.truncateToDouble() == itemTotal ? 0 : 2)} ر.س'
        : '\$ ${itemTotal.toStringAsFixed(2)}';

    return Dismissible(
      key: Key(item.product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: isArabic ? Alignment.centerLeft : Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFF4D4F),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
      onDismissed: (_) {
        CartState.removeItem(item.product.id);
        showAppSnackbar(
          context,
          isArabic ? 'تم حذف $title من السلة' : 'Removed $title from cart',
          type: SnackBarType.info,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                item.product.imagePath,
                width: 76,
                height: 76,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 76,
                  height: 76,
                  color: Colors.grey.shade100,
                  child: const Icon(Icons.restaurant, color: AppColor.textMuted),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: AppColor.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedTotal,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Stepper Quantity Control
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF6F7F9),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Row(
                children: [
                  // Minus
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      CartState.decrement(item.product.id);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(Icons.remove, size: 16, color: AppColor.textDark),
                      ),
                    ),
                  ),

                  // Quantity
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      unit == 'item' || unit == 'وجبة'
                          ? '${item.quantity}'
                          : '${item.quantity} $unit',
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: AppColor.textDark,
                      ),
                    ),
                  ),

                  // Plus
                  InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      CartState.increment(item.product.id);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(Icons.add, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Promo Voucher Section
  Widget _buildPromoSection(bool isArabic) {
    return ValueListenableBuilder<String?>(
      valueListenable: CartState.appliedPromoNotifier,
      builder: (context, promo, _) {
        if (promo != null) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFA5D6A7)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32)),
                    const SizedBox(width: 10),
                    Text(
                      isArabic ? 'كود الخصم نشط: $promo' : 'Coupon Applied: $promo',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    CartState.removePromoCode();
                    _promoController.clear();
                  },
                  child: const Icon(Icons.close_rounded, color: Color(0xFF2E7D32), size: 20),
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.local_offer_outlined, color: AppColor.primary, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _promoController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: isArabic ? 'أدخل كود الخصم (مثل SAVE20)' : 'Enter promo code (e.g. SAVE20)',
                    hintStyle: const TextStyle(fontSize: 13, color: AppColor.textMuted),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => _applyPromo(isArabic),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: Text(
                  isArabic ? 'تطبيق' : 'Apply',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Bill Summary Box
  Widget _buildBillSummary(bool isArabic) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'تفاصيل الفاتورة' : 'Bill Details',
            style: const TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.w800,
              color: AppColor.textDark,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(
            isArabic ? 'المجموع الفرعي' : 'Subtotal',
            _formatPrice(CartState.subtotal, isArabic),
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(
            isArabic ? 'رسوم التوصيل' : 'Delivery Fee',
            CartState.deliveryFee == 0
                ? (isArabic ? 'مجاناً' : 'Free')
                : _formatPrice(CartState.deliveryFee, isArabic),
            highlight: CartState.deliveryFee == 0,
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(
            isArabic ? 'ضريبة القيمة المضافة (5%)' : 'VAT (5%)',
            _formatPrice(CartState.tax, isArabic),
          ),
          if (CartState.discount > 0) ...[
            const SizedBox(height: 10),
            _buildSummaryRow(
              isArabic ? 'الخصم' : 'Discount',
              '- ${_formatPrice(CartState.discount, isArabic)}',
              highlight: true,
            ),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: Color(0xFFECEEF2)),
          ),
          _buildSummaryRow(
            isArabic ? 'الإجمالي الكلي' : 'Total Amount',
            _formatPrice(CartState.grandTotal, isArabic),
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isBold = false, bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 15.5 : 13.5,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
            color: isBold ? AppColor.textDark : AppColor.textMuted,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 17 : 14,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: highlight
                ? const Color(0xFF2E7D32)
                : (isBold ? AppColor.primary : AppColor.textDark),
          ),
        ),
      ],
    );
  }

  /// Sticky Bottom Checkout Action Bar
  Widget _buildCheckoutBar(bool isArabic) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final formattedGrandTotal = _formatPrice(CartState.grandTotal, isArabic);

    return Container(
      padding: EdgeInsets.fromLTRB(20, 14, 20, bottomInset > 0 ? bottomInset + 8 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Total Amount Info
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isArabic ? 'المبلغ الإجمالي' : 'Total Price',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColor.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                formattedGrandTotal,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColor.textDark,
                ),
              ),
            ],
          ),

          const SizedBox(width: 20),

          // Checkout Button
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _isCheckingOut ? null : () => _processCheckout(isArabic),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColor.primary.withValues(alpha: 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 4,
                  shadowColor: AppColor.primary.withValues(alpha: 0.35),
                ),
                child: _isCheckingOut
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.lock_outline_rounded, size: 19),
                          const SizedBox(width: 8),
                          Text(
                            isArabic ? 'إتمام الطلب' : 'Checkout',
                            style: const TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price, bool isArabic) {
    if (isArabic) {
      final formatted =
          price.truncateToDouble() == price ? price.toInt().toString() : price.toStringAsFixed(2);
      return '$formatted ر.س';
    } else {
      return '\$ ${price.toStringAsFixed(2)}';
    }
  }
}
