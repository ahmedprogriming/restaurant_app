import 'package:flutter/foundation.dart';

/// Clean Architecture Data Model for food and restaurant products.
@immutable
class ProductModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String imagePath;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviewCount;
  final int calories;
  final String unitEn;
  final String unitAr;
  final String deliveryTimeEn;
  final String deliveryTimeAr;
  final String descriptionEn;
  final String descriptionAr;
  final int likesCount;
  final bool isLiked;
  final String? videoUrl;
  final String categoryId;

  const ProductModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.imagePath,
    required this.price,
    this.oldPrice,
    this.rating = 4.9,
    this.reviewCount = 120,
    this.calories = 250,
    this.unitEn = 'item',
    this.unitAr = 'وجبة',
    this.deliveryTimeEn = '20 - 30 min',
    this.deliveryTimeAr = '20 - 30 دقيقة',
    required this.descriptionEn,
    required this.descriptionAr,
    this.likesCount = 5,
    this.isLiked = false,
    this.videoUrl,
    this.categoryId = 'all',
  });

  ProductModel copyWith({
    String? id,
    String? nameEn,
    String? nameAr,
    String? imagePath,
    double? price,
    double? oldPrice,
    double? rating,
    int? reviewCount,
    int? calories,
    String? unitEn,
    String? unitAr,
    String? deliveryTimeEn,
    String? deliveryTimeAr,
    String? descriptionEn,
    String? descriptionAr,
    int? likesCount,
    bool? isLiked,
    String? videoUrl,
    String? categoryId,
  }) {
    return ProductModel(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      calories: calories ?? this.calories,
      unitEn: unitEn ?? this.unitEn,
      unitAr: unitAr ?? this.unitAr,
      deliveryTimeEn: deliveryTimeEn ?? this.deliveryTimeEn,
      deliveryTimeAr: deliveryTimeAr ?? this.deliveryTimeAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      likesCount: likesCount ?? this.likesCount,
      isLiked: isLiked ?? this.isLiked,
      videoUrl: videoUrl ?? this.videoUrl,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  /// Default demo products matching user reference mockups
  static List<ProductModel> get sampleProducts => [
        // 1. Salmon Grill (سمك مشوي) - from Image 1
        const ProductModel(
          id: 'prod_salmon_1',
          nameEn: 'Grilled Salmon Steak',
          nameAr: 'سمك مشوي',
          imagePath: 'assets/images/product/pro1.jpg',
          price: 1500, // Matching the 1500 in image 1
          oldPrice: 1750,
          rating: 5.0,
          reviewCount: 342,
          calories: 380,
          unitEn: 'serving',
          unitAr: 'وجبة',
          deliveryTimeEn: '25 - 35 min',
          deliveryTimeAr: '25 - 35 دقيقة',
          descriptionEn:
              'Freshly grilled premium Atlantic salmon fillet seasoned with rosemary, sea salt, garlic, and freshly cracked black peppercorns, served with fresh lemon slices.',
          descriptionAr:
              'سمك مشوي طازج متبل بأجود أنواع البهارات مع إكليل الجبل والثوم وشرائح الليمون الشهية، مطهو على اللهب لتقديم نكهة بحرية لا تُقاوم وقيمة غذائية غنية بالأوميغا 3.',
          likesCount: 5,
          isLiked: true,
          videoUrl: 'https://example.com/salmon-recipe',
          categoryId: 'asian',
        ),

        // 2. Strawberry (فراولة) - from Image 2
        const ProductModel(
          id: 'prod_strawberry_2',
          nameEn: 'Strawberry',
          nameAr: 'فراولة طازجة',
          imagePath: 'assets/images/product/pro2.jpg',
          price: 56.68, // Matching $ 56.68 in image 2
          oldPrice: 65.0,
          rating: 4.9,
          reviewCount: 2645, // Matching 2645 in image 2
          calories: 33, // Matching 33 calories in image 2
          unitEn: 'kg',
          unitAr: 'كغ',
          deliveryTimeEn: '20 - 30 min',
          deliveryTimeAr: '20 - 30 دقيقة',
          descriptionEn:
              'The tiny strawberry is packed with vitamin C, fiber, antioxidants, and more. The heart-shaped silhouette of the strawberry is the first clue that this fruit is good for you. These potent little health wonders are picked fresh daily from organic farms.',
          descriptionAr:
              'حبات الفراولة الطازجة غنية بفيتامين ج، الألياف ومضادات الأكسدة. شكل الفراولة المميز يبرهن على فوائدها الصحية للجسم والقلب. تقطف يومياً من مزارع طبيعية لضمان النضارة والنكهة الغنية.',
          likesCount: 142,
          isLiked: false,
          videoUrl: 'https://example.com/strawberry-farm',
          categoryId: 'offers',
        ),

        // 3. Hollywood Burger
        const ProductModel(
          id: 'prod_burger_3',
          nameEn: 'Hollywood Starz Burger',
          nameAr: 'برجر هوليوود ستارز',
          imagePath: 'assets/images/category/cat3.png',
          price: 34.50,
          oldPrice: 42.0,
          rating: 4.9,
          reviewCount: 124,
          calories: 520,
          unitEn: 'item',
          unitAr: 'ساندوتش',
          deliveryTimeEn: '20 - 30 min',
          deliveryTimeAr: '20 - 30 دقيقة',
          descriptionEn:
              'Juicy charbroiled Angus beef patty layered with melted cheddar cheese, crisp lettuce, ripe tomatoes, caramelized onions, and our signature secret house sauce in a toasted brioche bun.',
          descriptionAr:
              'قطعة لحم أنجوس مشوية بعناية مع جبنة شيدر ذائبة، خس طازج، طماطم، بصل مكرمل وصوص هوليوود الخاص يقدم في خبز بريوش محمص.',
          likesCount: 89,
          isLiked: false,
          categoryId: 'burgers',
        ),

        // 4. Artisan Green Brunch
        const ProductModel(
          id: 'prod_brunch_4',
          nameEn: 'Artisan Green Avocado Salad',
          nameAr: 'سلطة الأفوكادو أرتيزان',
          imagePath: 'assets/images/product/pro3.jpg',
          price: 28.00,
          oldPrice: 32.0,
          rating: 4.7,
          reviewCount: 88,
          calories: 210,
          unitEn: 'bowl',
          unitAr: 'طبق',
          deliveryTimeEn: '15 - 20 min',
          deliveryTimeAr: '15 - 20 دقيقة',
          descriptionEn:
              'Crisp mixed greens, creamy avocado slices, cherry tomatoes, toasted pumpkin seeds, and crumbled feta cheese with extra virgin olive oil vinaigrette.',
          descriptionAr:
              'مزيج من الخضار الورقية الطازجة مع شرائح الأفوكادو، طماطم كرزية، بذور اليقطين المحمصة وجبنة الفيتا مع تتبيلة زيت الزيتون البكر الممتاز.',
          likesCount: 37,
          isLiked: false,
          categoryId: 'burgers',
        ),

        // 5. Wood-Fired Pizza
        const ProductModel(
          id: 'prod_pizza_5',
          nameEn: 'Bella Napoli Margherita Pizza',
          nameAr: 'بيتزا مارغريتا نابولي',
          imagePath: 'assets/images/category/cat1.png',
          price: 48.00,
          oldPrice: 55.0,
          rating: 4.9,
          reviewCount: 340,
          calories: 680,
          unitEn: 'pizza',
          unitAr: 'بيتزا',
          deliveryTimeEn: '20 - 30 min',
          deliveryTimeAr: '20 - 30 دقيقة',
          descriptionEn:
              'Authentic Neapolitan wood-fired pizza with San Marzano tomato sauce, fresh buffalo mozzarella, aromatic fresh basil, and extra virgin olive oil.',
          descriptionAr:
              'بيتزا نابولية أصلية مخبوزة على الحطب مع صلصة طماطم سان مارزانو، جبنة موزاريلا الجاموس الطازجة، أوراق الريحان العطرية وزيت الزيتون البكر.',
          likesCount: 210,
          isLiked: true,
          categoryId: 'pizza',
        ),
      ];
}
