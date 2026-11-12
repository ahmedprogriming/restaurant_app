import 'package:flutter/material.dart';
import 'package:restaurant/core/theam_color.dart';

/// A reusable restaurant/food card matching the reference mockup.
/// Displays a large rounded hero food image with delivery time badge,
/// restaurant title, star rating, ratings count, and food categories.
class RestaurantCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double rating;
  final dynamic ratingCount; // Can be int (e.g. 124) or formatted String
  final String category;
  final String cuisine;
  final String priceRange;
  final String deliveryTime;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const RestaurantCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.ratingCount,
    this.category = 'Cafe',
    this.cuisine = 'Western Food',
    this.priceRange = '\$\$',
    this.deliveryTime = '20 - 30 mins',
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedRatings = ratingCount is int
        ? '($ratingCount ratings)'
        : '($ratingCount)';

    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Container with floating Delivery Time badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(
                            Icons.restaurant_rounded,
                            size: 48,
                            color: AppColor.textMuted,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Floating Delivery Time Badge (bottom-right of the image)
                Positioned(
                  right: 14,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      deliveryTime,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textDark,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                ),

                // Optional Favorite Heart button on top-right
                if (onFavoriteTap != null)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onFavoriteTap,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.85),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: isFavorite
                                ? AppColor.primary
                                : AppColor.textDark,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 10),

            // Restaurant Title
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColor.textDark,
                letterSpacing: -0.2,
              ),
            ),

            const SizedBox(height: 5),

            // Rating and metadata row:
            // [★] [4.9] (124 ratings) Cafe · Western Food · $$
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 18,
                  color: AppColor.primary,
                ),
                const SizedBox(width: 3),
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primary,
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '$formattedRatings  $category · $cuisine · $priceRange',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColor.textMuted,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
