import 'package:flutter/material.dart';
import 'package:restaurant/core/app_language.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/models/product_model.dart';
import 'package:restaurant/routers/app_routes.dart';
import 'package:restaurant/widgets/cart_badge_icon.dart';
import 'package:restaurant/widgets/custom_back_button.dart';
import 'package:restaurant/widgets/custom_snackbar.dart';
import 'package:restaurant/widgets/restaurant_card.dart';

/// Clean Architecture Favorites Screen ("مفضلاتي")
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Favorite items list matching the app's visual style and assets
  late final List<Map<String, dynamic>> _favorites = [
    {
      'id': 'fav_1',
      'titleEn': 'Hollywood Starz Cafe',
      'titleAr': 'مقهى هوليوود ستارز',
      'imagePath': 'assets/images/category/cat3.png',
      'rating': 4.9,
      'ratingCount': 124,
      'categoryEn': 'Cafe',
      'categoryAr': 'كافيه',
      'cuisineEn': 'Western Food',
      'cuisineAr': 'طعام غربي',
      'priceRange': '\$\$',
      'deliveryTimeEn': '20 - 30 mins',
      'deliveryTimeAr': '20 - 30 دقيقة',
      'isFavorite': true,
    },
    {
      'id': 'fav_2',
      'titleEn': 'Berry Sweet Dessert & Ice Cream',
      'titleAr': 'محل حلوى التوت والآيسكريم',
      'imagePath': 'assets/images/product/pro2.jpg',
      'rating': 4.8,
      'ratingCount': 96,
      'categoryEn': 'Cafe',
      'categoryAr': 'كافيه',
      'cuisineEn': 'Desserts & Sweets',
      'cuisineAr': 'حلويات ومخبوزات',
      'priceRange': '\$',
      'deliveryTimeEn': '15 - 25 mins',
      'deliveryTimeAr': '15 - 25 دقيقة',
      'isFavorite': true,
    },
    {
      'id': 'fav_3',
      'titleEn': 'Ocean Fresh Salmon & Grill',
      'titleAr': 'مطعم أوشن للسلمون والمشاوي',
      'imagePath': 'assets/images/product/pro1.jpg',
      'rating': 4.9,
      'ratingCount': 215,
      'categoryEn': 'Seafood',
      'categoryAr': 'مأكولات بحرية',
      'cuisineEn': 'Western Food',
      'cuisineAr': 'طعام صحي ومشاوي',
      'priceRange': '\$\$\$',
      'deliveryTimeEn': '25 - 35 mins',
      'deliveryTimeAr': '25 - 35 دقيقة',
      'isFavorite': true,
    },
  ];

  void _removeFavorite(int index) {
    final item = _favorites[index];
    final isArabic = AppLanguage.isArabic;
    setState(() {
      _favorites.removeAt(index);
    });
    showAppSnackbar(
      context,
      isArabic
          ? 'تمت إزالة "${item['titleAr']}" من المفضلة'
          : 'Removed "${item['titleEn']}" from favorites',
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
                isArabic ? 'مفضلاتي' : 'My Favorites',
                style: const TextStyle(
                  color: AppColor.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: const [
                CartBadgeIcon(size: 38),
                SizedBox(width: 14),
              ],
            ),
            body: _favorites.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColor.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            size: 40,
                            color: AppColor.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isArabic ? 'لا توجد أطباق في المفضلة' : 'No favorite items yet',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColor.textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isArabic
                              ? 'قم بإضافة وجباتك ومطاعمك المفضلة لتظهر هنا'
                              : 'Add your favorite dishes to access them quickly',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColor.textMuted,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    itemCount: _favorites.length,
                    itemBuilder: (context, index) {
                      final item = _favorites[index];
                      return RestaurantCard(
                        title: isArabic ? item['titleAr'] : item['titleEn'],
                        imagePath: item['imagePath'],
                        rating: item['rating'],
                        ratingCount: item['ratingCount'],
                        category: isArabic ? item['categoryAr'] : item['categoryEn'],
                        cuisine: isArabic ? item['cuisineAr'] : item['cuisineEn'],
                        priceRange: item['priceRange'],
                        deliveryTime: isArabic
                            ? item['deliveryTimeAr']
                            : item['deliveryTimeEn'],
                        isFavorite: true,
                        onFavoriteTap: () => _removeFavorite(index),
                        onTap: () {
                          final samples = ProductModel.sampleProducts;
                          final product = samples.firstWhere(
                            (p) => p.imagePath == item['imagePath'],
                            orElse: () => ProductModel(
                              id: item['id'] as String,
                              nameEn: item['titleEn'] as String,
                              nameAr: item['titleAr'] as String,
                              imagePath: item['imagePath'] as String,
                              price: 50.0,
                              descriptionEn: 'Delicious favorite meal.',
                              descriptionAr: 'وجبة مميزة من المفضلة.',
                            ),
                          );
                          Navigator.pushNamed(
                            context,
                            AppRoutes.productDetail,
                            arguments: product,
                          );
                        },
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
