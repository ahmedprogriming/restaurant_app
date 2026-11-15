import 'package:flutter/material.dart';
import 'package:restaurant/models/product_model.dart';

/// Clean Architecture Data Model for a SubCategory / Food Type
@immutable
class SubCategoryModel {
  final String id;
  final String categoryId;
  final String nameEn;
  final String nameAr;
  final String imagePath;
  final int count;
  final List<ProductModel> products;

  const SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.nameEn,
    required this.nameAr,
    required this.imagePath,
    required this.count,
    this.products = const [],
  });

  SubCategoryModel copyWith({
    String? id,
    String? categoryId,
    String? nameEn,
    String? nameAr,
    String? imagePath,
    int? count,
    List<ProductModel>? products,
  }) {
    return SubCategoryModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      imagePath: imagePath ?? this.imagePath,
      count: count ?? this.count,
      products: products ?? this.products,
    );
  }
}

/// Clean Architecture Data Model for a Food Category
@immutable
class FoodCategoryModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String imagePath;
  final List<SubCategoryModel> subcategories;

  const FoodCategoryModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.imagePath,
    this.subcategories = const [],
  });

  /// Real categories & products matching the HomeScreen and restaurant menu
  static List<FoodCategoryModel> get sampleCategories => [
        // 1. مأكولات بحرية (Seafood)
        FoodCategoryModel(
          id: 'seafood',
          nameEn: 'Seafood',
          nameAr: 'مأكولات بحرية',
          imagePath: 'assets/images/category/cat8.png',
          subcategories: [
            SubCategoryModel(
              id: 'fish',
              categoryId: 'seafood',
              nameEn: 'Fish',
              nameAr: 'سمك',
              imagePath: 'assets/images/product/pro1.jpg',
              count: 10,
              products: [
                const ProductModel(
                  id: 'fish_1',
                  nameEn: 'Grilled Salmon Steak',
                  nameAr: 'سمك سلمون مشوي',
                  imagePath: 'assets/images/product/pro1.jpg',
                  price: 1500,
                  oldPrice: 1750,
                  rating: 5.0,
                  reviewCount: 342,
                  calories: 380,
                  unitEn: 'serving',
                  unitAr: 'وجبة',
                  deliveryTimeEn: '25 - 35 min',
                  deliveryTimeAr: '25 - 35 دقيقة',
                  descriptionEn:
                      'Freshly grilled premium Atlantic salmon fillet seasoned with rosemary, garlic, and fresh lemon slices.',
                  descriptionAr:
                      'سمك سلمون مشوي طازج متبل بإكليل الجبل والثوم وشرائح الليمون الشهية، مطهو على اللهب لتقديم نكهة بحرية لا تُقاوم.',
                  likesCount: 28,
                  isLiked: true,
                  categoryId: 'seafood',
                ),
                const ProductModel(
                  id: 'fish_2',
                  nameEn: 'Crispy Fried Fish Fillet',
                  nameAr: 'سمك فيليه مقلي مقرمش',
                  imagePath: 'assets/images/product/pro3.jpg',
                  price: 850,
                  oldPrice: 950,
                  rating: 4.8,
                  reviewCount: 215,
                  calories: 350,
                  unitEn: 'serving',
                  unitAr: 'وجبة',
                  deliveryTimeEn: '20 - 30 min',
                  deliveryTimeAr: '20 - 30 دقيقة',
                  descriptionEn:
                      'Crispy seasoned fish fillet fried to golden perfection, served with French fries and homemade tartar sauce.',
                  descriptionAr:
                      'فيليه سمك طازج مقلي بخلطة التتبيلة المقرمشة ويقدم مع البطاطس وصلصة التارتار اللذيذة.',
                  likesCount: 16,
                  isLiked: false,
                  categoryId: 'seafood',
                ),
                const ProductModel(
                  id: 'fish_3',
                  nameEn: 'Charcoal Grilled Sea Bream',
                  nameAr: 'سمك دنيس مشوي على الفحم',
                  imagePath: 'assets/images/product/pro1.jpg',
                  price: 1200,
                  oldPrice: 1350,
                  rating: 4.9,
                  reviewCount: 189,
                  calories: 320,
                  unitEn: 'serving',
                  unitAr: 'وجبة',
                  deliveryTimeEn: '25 - 30 min',
                  deliveryTimeAr: '25 - 30 دقيقة',
                  descriptionEn:
                      'Fresh whole sea bream grilled over charcoal with Mediterranean herbs, virgin olive oil, and lemon.',
                  descriptionAr:
                      'سمك دنيس طازج مشوي على الفحم بتتبيلة الأعشاب وزيت الزيتون البكر وعصير الليمون.',
                  likesCount: 21,
                  isLiked: false,
                  categoryId: 'seafood',
                ),
                const ProductModel(
                  id: 'fish_4',
                  nameEn: 'Baked Sea Bass with Herbs',
                  nameAr: 'سمك قاروص بالفرن بالأعشاب',
                  imagePath: 'assets/images/product/pro3.jpg',
                  price: 1350,
                  oldPrice: 1500,
                  rating: 4.9,
                  reviewCount: 270,
                  calories: 400,
                  unitEn: 'serving',
                  unitAr: 'وجبة',
                  deliveryTimeEn: '30 - 40 min',
                  deliveryTimeAr: '30 - 40 دقيقة',
                  descriptionEn:
                      'Tender sea bass baked with cherry tomatoes, garlic, extra virgin olive oil, and aromatic garden herbs.',
                  descriptionAr:
                      'سمك قاروص مطهو بالفرن مع الطماطم الكرزية وزيت الزيتون والليمون والأعشاب العطرية الطازجة.',
                  likesCount: 34,
                  isLiked: true,
                  categoryId: 'seafood',
                ),
              ],
            ),
            SubCategoryModel(
              id: 'shrimp',
              categoryId: 'seafood',
              nameEn: 'Shrimp',
              nameAr: 'قريدس',
              imagePath: 'assets/images/category/cat8.png',
              count: 10,
              products: [
                const ProductModel(
                  id: 'shrimp_1',
                  nameEn: 'Jumbo Grilled Shrimp',
                  nameAr: 'قريدس مشوي جامبو',
                  imagePath: 'assets/images/product/pro1.jpg',
                  price: 1400,
                  oldPrice: 1600,
                  rating: 4.9,
                  reviewCount: 154,
                  calories: 280,
                  unitEn: 'plate',
                  unitAr: 'طبق',
                  deliveryTimeEn: '20 - 30 min',
                  deliveryTimeAr: '20 - 30 دقيقة',
                  descriptionEn:
                      'Succulent jumbo shrimp grilled with garlic butter, fresh lemon, coriander, and herbs.',
                  descriptionAr:
                      'روبيان جامبو طازج مشوي بتتبيلة الثوم والليمون والكزبرة وزبدة الأعشاب الشهية.',
                  likesCount: 25,
                  isLiked: false,
                  categoryId: 'seafood',
                ),
                const ProductModel(
                  id: 'shrimp_2',
                  nameEn: 'Crispy Breaded Shrimp',
                  nameAr: 'قريدس مقلي كرانشي',
                  imagePath: 'assets/images/product/pro3.jpg',
                  price: 1200,
                  oldPrice: 1350,
                  rating: 4.8,
                  reviewCount: 98,
                  calories: 340,
                  unitEn: 'plate',
                  unitAr: 'طبق',
                  deliveryTimeEn: '15 - 25 min',
                  deliveryTimeAr: '15 - 25 دقيقة',
                  descriptionEn:
                      'Golden crispy breaded shrimp served with spicy cocktail sauce and crispy fries.',
                  descriptionAr:
                      'روبيان مقلي ذهبي مقرمش يقدم مع صلصة الكوكتيل الحارة والبطاطس المقرمشة.',
                  likesCount: 31,
                  isLiked: true,
                  categoryId: 'seafood',
                ),
              ],
            ),
            SubCategoryModel(
              id: 'calamari',
              categoryId: 'seafood',
              nameEn: 'Calamari',
              nameAr: 'كاليماري',
              imagePath: 'assets/images/category/cat9.png',
              count: 5,
              products: [
                const ProductModel(
                  id: 'calamari_1',
                  nameEn: 'Crispy Calamari Rings',
                  nameAr: 'حلقات كاليماري مقلية',
                  imagePath: 'assets/images/product/pro3.jpg',
                  price: 750,
                  oldPrice: 850,
                  rating: 4.7,
                  reviewCount: 88,
                  calories: 310,
                  unitEn: 'plate',
                  unitAr: 'طبق',
                  deliveryTimeEn: '15 - 20 min',
                  deliveryTimeAr: '15 - 20 دقيقة',
                  descriptionEn:
                      'Tender calamari rings fried until crispy golden, paired with garlic dip and fresh lemon.',
                  descriptionAr:
                      'حلقات حبار طازجة ومقرمشة متبلة ومقلية لدرجة الكمال مع صوص الثوم والليمون.',
                  likesCount: 19,
                  isLiked: false,
                  categoryId: 'seafood',
                ),
                const ProductModel(
                  id: 'calamari_2',
                  nameEn: 'Grilled Calamari with Herbs',
                  nameAr: 'كاليماري مشوي بالأعشاب',
                  imagePath: 'assets/images/product/pro1.jpg',
                  price: 900,
                  oldPrice: 1000,
                  rating: 4.8,
                  reviewCount: 72,
                  calories: 260,
                  unitEn: 'plate',
                  unitAr: 'طبق',
                  deliveryTimeEn: '20 - 25 min',
                  deliveryTimeAr: '20 - 25 دقيقة',
                  descriptionEn:
                      'Charbroiled calamari tossed with extra virgin olive oil, garlic, lemon zest, and parsley.',
                  descriptionAr:
                      'حبار طازج مشوي على الفحم مع زيت الزيتون البكر والثوم وبشر الليمون والبقدونس.',
                  likesCount: 15,
                  isLiked: false,
                  categoryId: 'seafood',
                ),
              ],
            ),
          ],
        ),

        // 2. برجر (Burgers) - Matches HomeScreen 'Burgers'
        FoodCategoryModel(
          id: 'burgers',
          nameEn: 'Burgers',
          nameAr: 'برجر',
          imagePath: 'assets/images/category/cat4.png',
          subcategories: [
            SubCategoryModel(
              id: 'beef_burgers',
              categoryId: 'burgers',
              nameEn: 'Beef Burgers',
              nameAr: 'برجر لحم أنجوس',
              imagePath: 'assets/images/category/cat3.png',
              count: 8,
              products: [
                const ProductModel(
                  id: 'burger_1',
                  nameEn: 'Hollywood Starz Burger',
                  nameAr: 'برجر هوليوود ستارز',
                  imagePath: 'assets/images/category/cat3.png',
                  price: 34.50,
                  oldPrice: 42.0,
                  rating: 4.9,
                  reviewCount: 124,
                  calories: 520,
                  unitEn: 'sandwich',
                  unitAr: 'ساندوتش',
                  deliveryTimeEn: '20 - 30 min',
                  deliveryTimeAr: '20 - 30 دقيقة',
                  descriptionEn:
                      'Juicy Angus beef patty with melted cheddar cheese, fresh lettuce, tomato, caramelized onion, and secret house sauce.',
                  descriptionAr:
                      'قطعة لحم أنجوس مشوية بعناية مع جبنة شيدر ذائبة، خس، طماطم، بصل مكرمل وصوص هوليوود الخاص في خبز بريوش محمص.',
                  likesCount: 89,
                  isLiked: true,
                  categoryId: 'burgers',
                ),
                const ProductModel(
                  id: 'burger_2',
                  nameEn: 'Double Bacon Cheeseburger',
                  nameAr: 'برجر دبل بيكون وجبن',
                  imagePath: 'assets/images/category/cat3.png',
                  price: 45.0,
                  oldPrice: 52.0,
                  rating: 4.8,
                  reviewCount: 96,
                  calories: 680,
                  unitEn: 'sandwich',
                  unitAr: 'ساندوتش',
                  deliveryTimeEn: '20 - 30 min',
                  deliveryTimeAr: '20 - 30 دقيقة',
                  descriptionEn:
                      'Two flame-grilled Angus beef patties layered with crispy beef bacon, double cheddar, and BBQ glaze.',
                  descriptionAr:
                      'شريحتان من لحم الأنجوس المشوي على اللهب مع بيكون بقري مقرمش، دبل شيدر وصوص الباربيكيو المدخن.',
                  likesCount: 47,
                  isLiked: false,
                  categoryId: 'burgers',
                ),
              ],
            ),
            SubCategoryModel(
              id: 'chicken_burgers',
              categoryId: 'burgers',
              nameEn: 'Chicken Burgers',
              nameAr: 'برجر دجاج مقرمش',
              imagePath: 'assets/images/category/cat4.png',
              count: 6,
              products: [
                const ProductModel(
                  id: 'chicken_burger_1',
                  nameEn: 'Super Crunchy Chicken Burger',
                  nameAr: 'سوبر كرانشي تشيكن برجر',
                  imagePath: 'assets/images/category/cat4.png',
                  price: 29.0,
                  oldPrice: 35.0,
                  rating: 4.8,
                  reviewCount: 110,
                  calories: 490,
                  unitEn: 'sandwich',
                  unitAr: 'ساندوتش',
                  deliveryTimeEn: '15 - 25 min',
                  deliveryTimeAr: '15 - 25 دقيقة',
                  descriptionEn:
                      'Crispy fried chicken breast fillet with homemade coleslaw, pickles, and creamy spicy mayo sauce.',
                  descriptionAr:
                      'صدر دجاج مقرمش متبل بخلطة خاصة مع سلطة الكولسلو ومخلل الخيار ومايونيز الشيف الحار.',
                  likesCount: 56,
                  isLiked: false,
                  categoryId: 'burgers',
                ),
              ],
            ),
          ],
        ),

        // 3. بيتزا (Pizza) - Matches HomeScreen 'Pizza'
        FoodCategoryModel(
          id: 'pizza',
          nameEn: 'Pizza',
          nameAr: 'بيتزا',
          imagePath: 'assets/images/category/cat1.png',
          subcategories: [
            SubCategoryModel(
              id: 'italian_pizza',
              categoryId: 'pizza',
              nameEn: 'Italian Pizza',
              nameAr: 'بيتزا إيطالية مخبوزة على الحطب',
              imagePath: 'assets/images/category/cat1.png',
              count: 8,
              products: [
                const ProductModel(
                  id: 'pizza_1',
                  nameEn: 'Bella Napoli Margherita Pizza',
                  nameAr: 'بيتزا مارغريتا نابولي',
                  imagePath: 'assets/images/category/cat1.png',
                  price: 48.0,
                  oldPrice: 55.0,
                  rating: 4.9,
                  reviewCount: 340,
                  calories: 680,
                  unitEn: 'pizza',
                  unitAr: 'بيتزا',
                  deliveryTimeEn: '20 - 30 min',
                  deliveryTimeAr: '20 - 30 دقيقة',
                  descriptionEn:
                      'Authentic Neapolitan wood-fired pizza with San Marzano tomato sauce, buffalo mozzarella, and fresh basil leaves.',
                  descriptionAr:
                      'بيتزا نابولية أصلية مخبوزة على الحطب مع صلصة طماطم سان مارزانو، جبنة موزاريلا الجاموس وأوراق الريحان العطرية.',
                  likesCount: 210,
                  isLiked: true,
                  categoryId: 'pizza',
                ),
                const ProductModel(
                  id: 'pizza_2',
                  nameEn: 'Pepperoni Supreme Pizza',
                  nameAr: 'بيتزا بيبروني خاصة',
                  imagePath: 'assets/images/category/cat1.png',
                  price: 55.0,
                  oldPrice: 62.0,
                  rating: 4.8,
                  reviewCount: 195,
                  calories: 740,
                  unitEn: 'pizza',
                  unitAr: 'بيتزا',
                  deliveryTimeEn: '20 - 30 min',
                  deliveryTimeAr: '20 - 30 دقيقة',
                  descriptionEn:
                      'San Marzano tomato sauce, mozzarella cheese, and generous layers of premium beef pepperoni.',
                  descriptionAr:
                      'صلصة طماطم إيطالية مع جبن الموزاريلا وطبقات سخية من شرائح البيبروني البقري المقرمشة.',
                  likesCount: 112,
                  isLiked: false,
                  categoryId: 'pizza',
                ),
              ],
            ),
          ],
        ),

        // 4. مشاوي (Grills & BBQ) - Matches HomeScreen cuisine
        FoodCategoryModel(
          id: 'grills',
          nameEn: 'Grills',
          nameAr: 'مشاوي',
          imagePath: 'assets/images/category/cat3.png',
          subcategories: [
            SubCategoryModel(
              id: 'mixed_grill',
              categoryId: 'grills',
              nameEn: 'Mixed Grill',
              nameAr: 'مشاوي مشكلة',
              imagePath: 'assets/images/category/cat3.png',
              count: 12,
              products: [
                const ProductModel(
                  id: 'grill_1',
                  nameEn: 'Luxury Mixed Grill Platter',
                  nameAr: 'مشاوي مشكلة فاخرة',
                  imagePath: 'assets/images/product/pro1.jpg',
                  price: 160.0,
                  oldPrice: 190.0,
                  rating: 4.9,
                  reviewCount: 310,
                  calories: 620,
                  unitEn: 'platter',
                  unitAr: 'طبق',
                  deliveryTimeEn: '25 - 35 min',
                  deliveryTimeAr: '25 - 35 دقيقة',
                  descriptionEn:
                      'Premium selection of charcoal grilled beef kebab, lamb chops, and marinated shish tawook served with grilled vegetables.',
                  descriptionAr:
                      'تشكيلة متميزة من كباب اللحم، شيش طاووق، وريش الضأن المشوية على الفحم مع البصل والطماطم المشوية والخبز الطازج.',
                  likesCount: 45,
                  isLiked: true,
                  categoryId: 'grills',
                ),
                const ProductModel(
                  id: 'grill_2',
                  nameEn: 'Fresh Lamb Chops Plate',
                  nameAr: 'ريش لحم ضأن طازجة',
                  imagePath: 'assets/images/product/pro1.jpg',
                  price: 180.0,
                  oldPrice: 210.0,
                  rating: 4.9,
                  reviewCount: 142,
                  calories: 580,
                  unitEn: 'plate',
                  unitAr: 'طبق',
                  deliveryTimeEn: '25 - 35 min',
                  deliveryTimeAr: '25 - 35 دقيقة',
                  descriptionEn:
                      'Tender lamb chops seasoned with Middle Eastern spices and grilled to perfection over charcoal.',
                  descriptionAr:
                      'ريش لحم ضأن طازجة ومتبلة بأجود أنواع البهارات الشرقية ومشوية على الفحم حتى النضوج التام.',
                  likesCount: 39,
                  isLiked: false,
                  categoryId: 'grills',
                ),
              ],
            ),
            SubCategoryModel(
              id: 'shish_tawook',
              categoryId: 'grills',
              nameEn: 'Shish Tawook',
              nameAr: 'شيش طاووق',
              imagePath: 'assets/images/category/cat3.png',
              count: 8,
              products: [
                const ProductModel(
                  id: 'tawook_1',
                  nameEn: 'Smoked Shish Tawook Platter',
                  nameAr: 'شيش طاووق مدخن',
                  imagePath: 'assets/images/product/pro1.jpg',
                  price: 95.0,
                  oldPrice: 110.0,
                  rating: 4.8,
                  reviewCount: 145,
                  calories: 450,
                  unitEn: 'plate',
                  unitAr: 'طبق',
                  deliveryTimeEn: '20 - 30 min',
                  deliveryTimeAr: '20 - 30 دقيقة',
                  descriptionEn:
                      'Tender chicken breast chunks marinated in Greek yogurt, garlic, lemon, and spices, flame-grilled on skewers.',
                  descriptionAr:
                      'صدور دجاج متبلة بخلطة الزبادي والليمون والثوم والأعشاب، مشوية على الفحم وتقدم مع صلصة الثومية والبطاطس.',
                  likesCount: 22,
                  isLiked: false,
                  categoryId: 'grills',
                ),
              ],
            ),
          ],
        ),

        // 5. مقبلات وسلطات (Appetizers & Salads)
        FoodCategoryModel(
          id: 'appetizers',
          nameEn: 'Appetizers & Salads',
          nameAr: 'مقبلات وسلطات',
          imagePath: 'assets/images/category/cat4.png',
          subcategories: [
            SubCategoryModel(
              id: 'salads',
              categoryId: 'appetizers',
              nameEn: 'Fresh Salads',
              nameAr: 'سلطات طازجة',
              imagePath: 'assets/images/product/pro3.jpg',
              count: 8,
              products: [
                const ProductModel(
                  id: 'salad_1',
                  nameEn: 'Artisan Green Avocado Salad',
                  nameAr: 'سلطة الأفوكادو أرتيزان',
                  imagePath: 'assets/images/product/pro3.jpg',
                  price: 28.0,
                  oldPrice: 32.0,
                  rating: 4.7,
                  reviewCount: 88,
                  calories: 210,
                  unitEn: 'bowl',
                  unitAr: 'طبق',
                  deliveryTimeEn: '15 - 20 min',
                  deliveryTimeAr: '15 - 20 دقيقة',
                  descriptionEn:
                      'Crisp mixed greens, creamy avocado slices, cherry tomatoes, pumpkin seeds, and feta with extra virgin olive oil.',
                  descriptionAr:
                      'مزيج من الخضار الورقية الطازجة مع شرائح الأفوكادو وطماطم كرزية وجبنة الفيتا وبذور اليقطين المحمصة مع زيت الزيتون.',
                  likesCount: 37,
                  isLiked: false,
                  categoryId: 'appetizers',
                ),
                const ProductModel(
                  id: 'salad_2',
                  nameEn: 'Classic Caesar Chicken Salad',
                  nameAr: 'سلطة سيزر بالدجاج المشوي',
                  imagePath: 'assets/images/product/pro3.jpg',
                  price: 35.0,
                  oldPrice: 40.0,
                  rating: 4.8,
                  reviewCount: 92,
                  calories: 320,
                  unitEn: 'bowl',
                  unitAr: 'طبق',
                  deliveryTimeEn: '15 - 20 min',
                  deliveryTimeAr: '15 - 20 دقيقة',
                  descriptionEn:
                      'Crisp romaine lettuce tossed in creamy Caesar dressing with grilled chicken, garlic croutons, and parmesan shavings.',
                  descriptionAr:
                      'خس روماني مقرمش مع صوص سيزر الكلاسيكي، قطع دجاج مشوي، خبز محمص وجبن بارميزان إيطالي أصلي.',
                  likesCount: 29,
                  isLiked: true,
                  categoryId: 'appetizers',
                ),
              ],
            ),
            SubCategoryModel(
              id: 'hummus',
              categoryId: 'appetizers',
              nameEn: 'Hummus & Dips',
              nameAr: 'حمص ومتبلات',
              imagePath: 'assets/images/category/cat4.png',
              count: 6,
              products: [
                const ProductModel(
                  id: 'hummus_1',
                  nameEn: 'Beiruti Hummus with Pine Nuts',
                  nameAr: 'حمص بيروتي بالصنوبر',
                  imagePath: 'assets/images/product/pro3.jpg',
                  price: 22.0,
                  oldPrice: 26.0,
                  rating: 4.8,
                  reviewCount: 65,
                  calories: 180,
                  unitEn: 'plate',
                  unitAr: 'صحن',
                  deliveryTimeEn: '10 - 15 min',
                  deliveryTimeAr: '10 - 15 دقيقة',
                  descriptionEn:
                      'Creamy hummus blended with tahini, extra virgin olive oil, lemon, topped with toasted pine nuts and warm pita.',
                  descriptionAr:
                      'حمص كريمي غني بالطحينة وزيت الزيتون البكر مع حبوب الصنوبر المحمصة يقدم مع خبز التنور الساخن.',
                  likesCount: 18,
                  isLiked: false,
                  categoryId: 'appetizers',
                ),
              ],
            ),
          ],
        ),

        // 6. هوت دوج (Hotdog) - Matches HomeScreen 'Hotdog'
        FoodCategoryModel(
          id: 'hotdog',
          nameEn: 'Hotdog',
          nameAr: 'هوت دوج',
          imagePath: 'assets/images/category/cat5.png',
          subcategories: [
            SubCategoryModel(
              id: 'hotdog_sandwiches',
              categoryId: 'hotdog',
              nameEn: 'Hotdog Sandwiches',
              nameAr: 'سندويشات هوت دوج',
              imagePath: 'assets/images/category/cat5.png',
              count: 6,
              products: [
                const ProductModel(
                  id: 'hotdog_1',
                  nameEn: 'Supreme Hotdog Sandwich',
                  nameAr: 'ساندوتش هوت دوج سوبريم',
                  imagePath: 'assets/images/category/cat5.png',
                  price: 25.0,
                  oldPrice: 30.0,
                  rating: 4.6,
                  reviewCount: 78,
                  calories: 420,
                  unitEn: 'sandwich',
                  unitAr: 'ساندوتش',
                  deliveryTimeEn: '15 - 20 min',
                  deliveryTimeAr: '15 - 20 دقيقة',
                  descriptionEn:
                      'Grilled premium beef hotdog topped with melted cheddar, mustard, ketchup, relish, and diced crispy onions.',
                  descriptionAr:
                      'هوت دوج مشوي مع جبنة شيدر، المستردة والكاتشب ومخلل الخيار المقرمش والبصل المقرمش.',
                  likesCount: 22,
                  isLiked: false,
                  categoryId: 'hotdog',
                ),
              ],
            ),
          ],
        ),

        // 7. بطاطس (Fries) - Matches HomeScreen 'Fries'
        FoodCategoryModel(
          id: 'fries',
          nameEn: 'Fries',
          nameAr: 'بطاطس',
          imagePath: 'assets/images/category/cat6.png',
          subcategories: [
            SubCategoryModel(
              id: 'fries_sides',
              categoryId: 'fries',
              nameEn: 'Fries & Sides',
              nameAr: 'بطاطس مقلية ومقبلات ساخنة',
              imagePath: 'assets/images/category/cat6.png',
              count: 6,
              products: [
                const ProductModel(
                  id: 'fries_1',
                  nameEn: 'Crispy French Fries',
                  nameAr: 'بطاطس مقلية مقرمشة',
                  imagePath: 'assets/images/category/cat6.png',
                  price: 15.0,
                  oldPrice: 18.0,
                  rating: 4.8,
                  reviewCount: 220,
                  calories: 320,
                  unitEn: 'portion',
                  unitAr: 'حصة',
                  deliveryTimeEn: '10 - 15 min',
                  deliveryTimeAr: '10 - 15 دقيقة',
                  descriptionEn:
                      'Golden french fries seasoned with our signature spice blend, hot and crispy.',
                  descriptionAr:
                      'أصابع بطاطس ذهبية مقلية طازجة ومقرمشة مع رشة بهارات الواحة الخاصة.',
                  likesCount: 52,
                  isLiked: true,
                  categoryId: 'fries',
                ),
                const ProductModel(
                  id: 'fries_2',
                  nameEn: 'Cheese & Jalapeno Loaded Fries',
                  nameAr: 'بطاطس بالجبنة والهلابينو',
                  imagePath: 'assets/images/category/cat6.png',
                  price: 22.0,
                  oldPrice: 26.0,
                  rating: 4.9,
                  reviewCount: 165,
                  calories: 460,
                  unitEn: 'portion',
                  unitAr: 'حصة',
                  deliveryTimeEn: '10 - 15 min',
                  deliveryTimeAr: '10 - 15 دقيقة',
                  descriptionEn:
                      'Crispy french fries smothered in melted cheddar cheese sauce and fiery sliced jalapenos.',
                  descriptionAr:
                      'بطاطس مقلية مقرمشة مغطاة بصلصة جبنة الشيدر الذائبة الغنية وقطع الهلابينو الحارة.',
                  likesCount: 41,
                  isLiked: false,
                  categoryId: 'fries',
                ),
              ],
            ),
          ],
        ),

        // 8. ناجتس (Nuggets) - Matches HomeScreen 'Nuggets'
        FoodCategoryModel(
          id: 'nuggets',
          nameEn: 'Nuggets',
          nameAr: 'ناجتس',
          imagePath: 'assets/images/category/cat7.png',
          subcategories: [
            SubCategoryModel(
              id: 'nuggets_meals',
              categoryId: 'nuggets',
              nameEn: 'Nugget Meals',
              nameAr: 'وجبات الناجتس المقرمشة',
              imagePath: 'assets/images/category/cat7.png',
              count: 5,
              products: [
                const ProductModel(
                  id: 'nuggets_1',
                  nameEn: 'Golden Crispy Chicken Nuggets',
                  nameAr: 'ناجتس الدجاج الذهبي المقرمش',
                  imagePath: 'assets/images/category/cat7.png',
                  price: 26.0,
                  oldPrice: 30.0,
                  rating: 4.8,
                  reviewCount: 180,
                  calories: 410,
                  unitEn: 'meal',
                  unitAr: 'وجبة',
                  deliveryTimeEn: '15 - 20 min',
                  deliveryTimeAr: '15 - 20 دقيقة',
                  descriptionEn:
                      'Tender golden chicken nuggets coated in crunchy breading, served with french fries and honey mustard dip.',
                  descriptionAr:
                      'قطع ناجتس دجاج ذهبية مقرمشة وطرية من الداخل، تقدم مع البطاطس المقلية وصوص الخردل بالعسل.',
                  likesCount: 48,
                  isLiked: false,
                  categoryId: 'nuggets',
                ),
              ],
            ),
          ],
        ),

        // 9. مكسيكي (Mexican) - Matches HomeScreen 'Mexican'
        FoodCategoryModel(
          id: 'nachos',
          nameEn: 'Mexican',
          nameAr: 'مكسيكي',
          imagePath: 'assets/images/category/cat9.png',
          subcategories: [
            SubCategoryModel(
              id: 'mexican_tacos',
              categoryId: 'nachos',
              nameEn: 'Nachos & Tacos',
              nameAr: 'ناتشوز وتاكو مكسيكي',
              imagePath: 'assets/images/category/cat9.png',
              count: 6,
              products: [
                const ProductModel(
                  id: 'nachos_1',
                  nameEn: 'Supreme Nachos with Beef & Cheese',
                  nameAr: 'ناتشوز سوبريم بالجبن واللحم',
                  imagePath: 'assets/images/category/cat9.png',
                  price: 32.0,
                  oldPrice: 38.0,
                  rating: 4.8,
                  reviewCount: 95,
                  calories: 520,
                  unitEn: 'plate',
                  unitAr: 'طبق',
                  deliveryTimeEn: '15 - 20 min',
                  deliveryTimeAr: '15 - 20 دقيقة',
                  descriptionEn:
                      'Crisp tortilla chips loaded with seasoned minced beef, warm melted cheese, salsa, and guacamole.',
                  descriptionAr:
                      'رقائق تورتيلا مقرمشة مغطاة باللحم المفروم المتبل، صوص الجبن الذائب، الصلصة المكسيكية والغواكامولي.',
                  likesCount: 35,
                  isLiked: true,
                  categoryId: 'nachos',
                ),
              ],
            ),
          ],
        ),

        // 10. حلويات ومشروبات (Desserts & Drinks) - Matches HomeScreen 'Berry Sweet' & 'Drinks'
        FoodCategoryModel(
          id: 'desserts_drinks',
          nameEn: 'Desserts & Drinks',
          nameAr: 'حلويات ومشروبات',
          imagePath: 'assets/images/product/pro2.jpg',
          subcategories: [
            SubCategoryModel(
              id: 'desserts',
              categoryId: 'desserts_drinks',
              nameEn: 'Desserts & Fruits',
              nameAr: 'حلويات وفواكه',
              imagePath: 'assets/images/product/pro2.jpg',
              count: 8,
              products: [
                const ProductModel(
                  id: 'dessert_1',
                  nameEn: 'Fresh Strawberry with Cream',
                  nameAr: 'فراولة طازجة بالكريمة',
                  imagePath: 'assets/images/product/pro2.jpg',
                  price: 56.68,
                  oldPrice: 65.0,
                  rating: 4.9,
                  reviewCount: 2645,
                  calories: 33,
                  unitEn: 'portion',
                  unitAr: 'طبق',
                  deliveryTimeEn: '15 - 25 min',
                  deliveryTimeAr: '15 - 25 دقيقة',
                  descriptionEn:
                      'Fresh hand-picked organic strawberries served with light whipped cream and pure natural honey.',
                  descriptionAr:
                      'حبات الفراولة الطبيعية الطازجة قطفت بعناية، تقدم مع الكريمة الخفيفة المخفوقة والعسل الصافي.',
                  likesCount: 142,
                  isLiked: false,
                  categoryId: 'desserts_drinks',
                ),
              ],
            ),
            SubCategoryModel(
              id: 'drinks',
              categoryId: 'desserts_drinks',
              nameEn: 'Fresh Juices & Drinks',
              nameAr: 'مشروبات وعصائر طبيعية',
              imagePath: 'assets/images/category/cat10.png',
              count: 10,
              products: [
                const ProductModel(
                  id: 'drink_1',
                  nameEn: 'Fresh Natural Orange Juice',
                  nameAr: 'عصير برتقال طبيعي طازج',
                  imagePath: 'assets/images/category/cat10.png',
                  price: 18.0,
                  oldPrice: 22.0,
                  rating: 4.9,
                  reviewCount: 210,
                  calories: 110,
                  unitEn: 'cup',
                  unitAr: 'كوب',
                  deliveryTimeEn: '10 - 15 min',
                  deliveryTimeAr: '10 - 15 دقيقة',
                  descriptionEn:
                      'Pure freshly squeezed Valencia orange juice without added sugar or preservatives, loaded with vitamin C.',
                  descriptionAr:
                      'عصير برتقال طبيعي معصور طازج بدون أي إضافات أو سكر مضاف، غني بفيتامين ج المنعش.',
                  likesCount: 65,
                  isLiked: true,
                  categoryId: 'desserts_drinks',
                ),
              ],
            ),
          ],
        ),
      ];
}
