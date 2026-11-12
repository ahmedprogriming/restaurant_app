import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/core/theam_color.dart';
import 'package:restaurant/widgets/category_card.dart';
import 'package:restaurant/widgets/custom_search_bar.dart';
import 'package:restaurant/widgets/custom_snackbar.dart';
import 'package:restaurant/widgets/delivery_location_header.dart';
import 'package:restaurant/widgets/home_bottom_nav_bar.dart';
import 'package:restaurant/widgets/restaurant_card.dart';

/// Data model representing a Category
class CategoryModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String? imagePath;
  final Widget? customIcon;

  const CategoryModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.imagePath,
    this.customIcon,
  });
}

/// Data model representing a Restaurant / Dish Item
class RestaurantModel {
  final String id;
  final String title;
  final String titleAr;
  final String imagePath;
  final double rating;
  final int ratingCount;
  final String categoryEn;
  final String categoryAr;
  final String cuisineEn;
  final String cuisineAr;
  final String priceRange;
  final String deliveryTimeEn;
  final String deliveryTimeAr;
  final String categoryId;
  final bool isFavorite;

  const RestaurantModel({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.imagePath,
    required this.rating,
    required this.ratingCount,
    required this.categoryEn,
    required this.categoryAr,
    required this.cuisineEn,
    required this.cuisineAr,
    required this.priceRange,
    required this.deliveryTimeEn,
    required this.deliveryTimeAr,
    required this.categoryId,
    this.isFavorite = false,
  });

  RestaurantModel copyWith({bool? isFavorite}) {
    return RestaurantModel(
      id: id,
      title: title,
      titleAr: titleAr,
      imagePath: imagePath,
      rating: rating,
      ratingCount: ratingCount,
      categoryEn: categoryEn,
      categoryAr: categoryAr,
      cuisineEn: cuisineEn,
      cuisineAr: cuisineAr,
      priceRange: priceRange,
      deliveryTimeEn: deliveryTimeEn,
      deliveryTimeAr: deliveryTimeAr,
      categoryId: categoryId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

/// Home Screen closely matching the reference mockup UI.
class HomeScreen extends StatefulWidget {
  final bool initialIsArabic;

  const HomeScreen({
    super.key,
    this.initialIsArabic = false,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _isArabic;
  int _selectedCategoryIndex = -1; // -1 shows all by default, or tap any category to filter
  int _currentNavIndex = 0;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // Categories matching the screenshot: Offers, Burgers, Asian, Pizza, and additional assets
  late final List<CategoryModel> _categories = [
    const CategoryModel(
      id: 'offers',
      nameEn: 'Offers',
      nameAr: 'العروض',
      customIcon: OffersGiftBoxIcon(size: 38),
    ),
    const CategoryModel(
      id: 'burgers',
      nameEn: 'Burgers',
      nameAr: 'برجر',
      imagePath: 'assets/images/category/cat4.png',
    ),
    const CategoryModel(
      id: 'asian',
      nameEn: 'Asian',
      nameAr: 'آسيوي',
      imagePath: 'assets/images/category/cat8.png',
    ),
    const CategoryModel(
      id: 'pizza',
      nameEn: 'Pizza',
      nameAr: 'بيتزا',
      imagePath: 'assets/images/category/cat1.png',
    ),
    const CategoryModel(
      id: 'hotdog',
      nameEn: 'Hotdog',
      nameAr: 'هوت دوج',
      imagePath: 'assets/images/category/cat5.png',
    ),
    const CategoryModel(
      id: 'fries',
      nameEn: 'Fries',
      nameAr: 'بطاطس',
      imagePath: 'assets/images/category/cat6.png',
    ),
    const CategoryModel(
      id: 'nuggets',
      nameEn: 'Nuggets',
      nameAr: 'ناجتس',
      imagePath: 'assets/images/category/cat7.png',
    ),
    const CategoryModel(
      id: 'nachos',
      nameEn: 'Mexican',
      nameAr: 'مكسيكي',
      imagePath: 'assets/images/category/cat9.png',
    ),
    const CategoryModel(
      id: 'drinks',
      nameEn: 'Drinks',
      nameAr: 'مشروبات',
      imagePath: 'assets/images/category/cat10.png',
    ),
  ];

  // Restaurant & Food Items matching the mockup and utilizing user assets
  late final List<RestaurantModel> _restaurants = [
    const RestaurantModel(
      id: '1',
      title: 'Hollywood Starz Cafe',
      titleAr: 'مقهى هوليوود ستارز',
      imagePath: 'assets/images/category/cat3.png',
      rating: 4.9,
      ratingCount: 124,
      categoryEn: 'Cafe',
      categoryAr: 'كافيه',
      cuisineEn: 'Western Food',
      cuisineAr: 'طعام غربي',
      priceRange: '\$\$',
      deliveryTimeEn: '20 - 30 mins',
      deliveryTimeAr: '20 - 30 دقيقة',
      categoryId: 'burgers',
    ),
    const RestaurantModel(
      id: '2',
      title: 'Berry Sweet Dessert & Ice Cream',
      titleAr: 'محل حلوى التوت والآيسكريم',
      imagePath: 'assets/images/product/pro2.jpg',
      rating: 4.8,
      ratingCount: 96,
      categoryEn: 'Cafe',
      categoryAr: 'كافيه',
      cuisineEn: 'Desserts & Sweets',
      cuisineAr: 'حلويات ومخبوزات',
      priceRange: '\$',
      deliveryTimeEn: '15 - 25 mins',
      deliveryTimeAr: '15 - 25 دقيقة',
      categoryId: 'offers',
    ),
    const RestaurantModel(
      id: '3',
      title: 'Ocean Fresh Salmon & Grill',
      titleAr: 'مطعم أوشن للسلمون والمشاوي',
      imagePath: 'assets/images/product/pro1.jpg',
      rating: 4.9,
      ratingCount: 215,
      categoryEn: 'Seafood',
      categoryAr: 'مأكولات بحرية',
      cuisineEn: 'Western Food',
      cuisineAr: 'طعام صحي ومشاوي',
      priceRange: '\$\$\$',
      deliveryTimeEn: '25 - 35 mins',
      deliveryTimeAr: '25 - 35 دقيقة',
      categoryId: 'asian',
    ),
    const RestaurantModel(
      id: '4',
      title: 'Green Artisan Brunch & Bakery',
      titleAr: 'مخبز وبرنش أرتيزان الأخضر',
      imagePath: 'assets/images/product/pro3.jpg',
      rating: 4.7,
      ratingCount: 88,
      categoryEn: 'Bakery',
      categoryAr: 'مخبوزات',
      cuisineEn: 'Healthy Food',
      cuisineAr: 'طعام صحي وفطور',
      priceRange: '\$\$',
      deliveryTimeEn: '15 - 20 mins',
      deliveryTimeAr: '15 - 20 دقيقة',
      categoryId: 'burgers',
    ),
    const RestaurantModel(
      id: '5',
      title: 'Bella Napoli Stone Oven Pizza',
      titleAr: 'بيتزا بيلا نابولي بالفرن الحجري',
      imagePath: 'assets/images/category/cat1.png',
      rating: 4.9,
      ratingCount: 340,
      categoryEn: 'Italian',
      categoryAr: 'إيطالي',
      cuisineEn: 'Wood-Fired Pizza',
      cuisineAr: 'بيتزا إيطالية',
      priceRange: '\$\$',
      deliveryTimeEn: '20 - 30 mins',
      deliveryTimeAr: '20 - 30 دقيقة',
      categoryId: 'pizza',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _isArabic = widget.initialIsArabic;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleLanguage() {
    setState(() {
      _isArabic = !_isArabic;
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      _restaurants[index] = _restaurants[index].copyWith(
        isFavorite: !_restaurants[index].isFavorite,
      );
    });
    showAppSnackbar(
      context,
      _restaurants[index].isFavorite
          ? (_isArabic
              ? 'تمت إضافة ${_restaurants[index].titleAr} إلى المفضلة ❤️'
              : 'Added ${_restaurants[index].title} to favorites ❤️')
          : (_isArabic
              ? 'تمت الإزالة من المفضلة'
              : 'Removed from favorites'),
      type: SnackBarType.info,
    );
  }

  void _showLocationPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Directionality(
          textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isArabic ? 'اختر موقع التوصيل' : 'Select Delivery Location',
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
                ListTile(
                  leading: const Icon(Icons.my_location_rounded, color: AppColor.primary),
                  title: Text(_isArabic ? 'الموقع الحالي' : 'Current location'),
                  subtitle: Text(_isArabic ? 'شارع الملك فهد، الرياض' : 'King Fahd Road, Riyadh'),
                  trailing: const Icon(Icons.check_circle_rounded, color: AppColor.primary),
                  onTap: () => Navigator.pop(ctx),
                ),
                ListTile(
                  leading: const Icon(Icons.home_outlined, color: AppColor.textMuted),
                  title: Text(_isArabic ? 'المنزل' : 'Home'),
                  subtitle: Text(_isArabic ? 'حي النرجس، الرياض' : 'Al Narjis, Riyadh'),
                  onTap: () => Navigator.pop(ctx),
                ),
                ListTile(
                  leading: const Icon(Icons.work_outline, color: AppColor.textMuted),
                  title: Text(_isArabic ? 'العمل' : 'Office'),
                  subtitle: Text(_isArabic ? 'الواحة، الرياض' : 'Al Waha, Riyadh'),
                  onTap: () => Navigator.pop(ctx),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Directionality(
          textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isArabic ? 'تصفية المطاعم' : 'Filter Restaurants',
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
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: Text(_isArabic ? 'الأعلى تقييماً ★' : 'Top Rated ★'),
                      selected: true,
                      selectedColor: AppColor.primary.withValues(alpha: 0.15),
                      checkmarkColor: AppColor.primary,
                      onSelected: (val) {},
                    ),
                    FilterChip(
                      label: Text(_isArabic ? 'توصيل سريع' : 'Fast Delivery'),
                      selected: false,
                      onSelected: (val) {},
                    ),
                    FilterChip(
                      label: Text(_isArabic ? 'عروض خاصة' : 'Offers & Discounts'),
                      selected: false,
                      onSelected: (val) {},
                    ),
                    FilterChip(
                      label: Text(_isArabic ? 'شائع الآن' : 'Popular Now'),
                      selected: false,
                      onSelected: (val) {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(_isArabic ? 'تطبيق الفلتر' : 'Apply Filter'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<RestaurantModel> get _filteredRestaurants {
    var list = _restaurants;
    // Category filter: if a category is selected (and not 'offers'), filter by category
    if (_selectedCategoryIndex >= 0 && _selectedCategoryIndex < _categories.length) {
      final selectedCat = _categories[_selectedCategoryIndex];
      if (selectedCat.id != 'offers') {
        final matches = list.where((r) => r.categoryId == selectedCat.id).toList();
        if (matches.isNotEmpty) {
          list = matches;
        }
      }
    }
    // Search filter
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((r) {
        return r.title.toLowerCase().contains(q) ||
            r.titleAr.toLowerCase().contains(q) ||
            r.cuisineEn.toLowerCase().contains(q) ||
            r.categoryEn.toLowerCase().contains(q);
      }).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = _isArabic ? TextDirection.rtl : TextDirection.ltr;
    final filteredList = _filteredRestaurants;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Directionality(
        textDirection: textDirection,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                // Top App Header: Location & Language Switcher
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 12.0,
                      bottom: 16.0,
                    ),
                    child: DeliveryLocationHeader(
                      label: _isArabic ? 'التوصيل إلى' : 'Delivering to',
                      location: _isArabic ? 'الموقع الحالي' : 'Current location',
                      onTap: _showLocationPicker,
                      trailing: IconButton(
                        tooltip: _isArabic ? 'Switch to English' : 'التحويل للعربية',
                        onPressed: _toggleLanguage,
                        icon: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColor.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Text(
                            _isArabic ? 'EN' : 'عربي',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Search Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomSearchBar(
                      hintText: _isArabic ? 'ابحث عن الوجبات أو المطاعم' : 'Search foods',
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      onFilterTap: _showFilterSheet,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 22)),

                // Horizontal Categories Scroll
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 108,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        final isSelected = index == _selectedCategoryIndex;

                        return CategoryCard(
                          title: _isArabic ? cat.nameAr : cat.nameEn,
                          imagePath: cat.imagePath,
                          customIcon: cat.customIcon,
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              if (_selectedCategoryIndex == index) {
                                _selectedCategoryIndex = -1;
                              } else {
                                _selectedCategoryIndex = index;
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // Restaurant Cards List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = filteredList[index];
                        return RestaurantCard(
                          title: _isArabic ? item.titleAr : item.title,
                          imagePath: item.imagePath,
                          rating: item.rating,
                          ratingCount: item.ratingCount,
                          category: _isArabic ? item.categoryAr : item.categoryEn,
                          cuisine: _isArabic ? item.cuisineAr : item.cuisineEn,
                          priceRange: item.priceRange,
                          deliveryTime: _isArabic
                              ? item.deliveryTimeAr
                              : item.deliveryTimeEn,
                          isFavorite: item.isFavorite,
                          onFavoriteTap: () => _toggleFavorite(index),
                          onTap: () {
                            showAppSnackbar(
                              context,
                              _isArabic
                                  ? 'تم اختيار ${item.titleAr}'
                                  : 'Selected ${item.title}',
                              type: SnackBarType.success,
                            );
                          },
                        );
                      },
                      childCount: filteredList.length,
                    ),
                  ),
                ),

                // Bottom spacer for scroll comfort above bottom navigation bar
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            ),
          ),
          bottomNavigationBar: HomeBottomNavBar(
            currentIndex: _currentNavIndex,
            isArabic: _isArabic,
            onTap: (index) {
              setState(() {
                _currentNavIndex = index;
              });
              if (index == 1) {
                // Tapped Offers tab
                setState(() {
                  _selectedCategoryIndex = 0;
                });
                showAppSnackbar(
                  context,
                  _isArabic ? 'قسم العروض والخصومات 🔥' : 'Offers & Discounts 🔥',
                  type: SnackBarType.info,
                );
              } else if (index == 2) {
                // Tapped Account tab
                showAppSnackbar(
                  context,
                  _isArabic ? 'صفحة الحساب الشخصي' : 'Account & Profile',
                  type: SnackBarType.info,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
