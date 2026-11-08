import 'package:flutter/material.dart';
import 'package:restaurant/core/theam_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  int _currentNavIndex = 0;

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'الكل', 'icon': Icons.restaurant_menu},
    {'name': 'برجر', 'icon': Icons.lunch_dining},
    {'name': 'بيتزا', 'icon': Icons.local_pizza},
    {'name': 'مشروبات', 'icon': Icons.local_cafe},
    {'name': 'حلويات', 'icon': Icons.cake},
  ];

  final List<Map<String, dynamic>> _popularMeals = const [
    {
      'title': 'برجر كلاسيك بيف',
      'restaurant': 'مطعم الواحة',
      'price': '32.00 ر.س',
      'rating': '4.9',
      'time': '20-30 دقيقة',
      'icon': Icons.lunch_dining,
      'color': Color(0xFFFFF3E0),
      'iconColor': Color(0xFFE65100),
    },
    {
      'title': 'بيتزا مارجريتا إيطالي',
      'restaurant': 'بيتزا هاوس',
      'price': '45.00 ر.س',
      'rating': '4.8',
      'time': '25-35 دقيقة',
      'icon': Icons.local_pizza,
      'color': Color(0xFFFFEBEE),
      'iconColor': Color(0xFFC62828),
    },
    {
      'title': 'وجبة مشويات مشكلة',
      'restaurant': 'قصر الشواء',
      'price': '68.00 ر.س',
      'rating': '4.9',
      'time': '30-40 دقيقة',
      'icon': Icons.kebab_dining,
      'color': Color(0xFFFBE9E7),
      'iconColor': Color(0xFFD84315),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'التوصيل إلى',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.textMuted,
                fontWeight: FontWeight.normal,
              ),
            ),
            Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: AppColor.primary,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'الرياض، حي النرجس',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.textDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.textDark,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColor.textDark,
                  size: 26,
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColor.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColor.primary, Color(0xFFFF7E84)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primary.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'خصم 30% على أول طلب! 🎉',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'استخدم كود HAPPY عند الدفع',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.local_offer_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'ابحث عن وجبة أو مطعم...',
                    hintStyle: TextStyle(
                      color: AppColor.textMuted,
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColor.textMuted,
                    ),
                    suffixIcon: Icon(
                      Icons.tune,
                      color: AppColor.primary,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Categories Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'التصنيفات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textDark,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'عرض الكل',
                      style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Categories Horizontal List
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, index) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final item = _categories[index];
                    final isSelected = index == _selectedCategoryIndex;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColor.primary : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? AppColor.primary.withValues(alpha: 0.3)
                                  : Colors.black.withValues(alpha: 0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item['icon'] as IconData,
                              size: 18,
                              color: isSelected
                                  ? Colors.white
                                  : AppColor.textDark,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              item['name'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : AppColor.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Popular Meals Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'الوجبات الأكثر طلباً 🔥',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textDark,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'المزيد',
                      style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Popular Meals List
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _popularMeals.length,
                separatorBuilder: (_, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final meal = _popularMeals[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
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
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: meal['color'] as Color,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            meal['icon'] as IconData,
                            color: meal['iconColor'] as Color,
                            size: 36,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meal['title'] as String,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                meal['restaurant'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColor.textMuted,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    meal['rating'] as String,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.textDark,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    Icons.access_time_rounded,
                                    size: 14,
                                    color: AppColor.textMuted,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    meal['time'] as String,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColor.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              meal['price'] as String,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('تمت إضافة ${meal['title']} للسلة'),
                                    duration: const Duration(seconds: 1),
                                    backgroundColor: AppColor.primary,
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.textMuted,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'استكشف',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'الطلبات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}
