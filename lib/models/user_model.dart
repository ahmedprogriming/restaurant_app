/// Clean Architecture Data Model for User Profile
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String avatarUrl;
  final int totalOrders;
  final int favoriteCount;
  final double walletBalance;
  final bool notificationsEnabled;
  final String memberTier;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '+966 55 123 4567',
    this.address = 'شارع الملك فهد، حي النرجس، الرياض',
    this.avatarUrl = '',
    this.totalOrders = 12,
    this.favoriteCount = 5,
    this.walletBalance = 145.50,
    this.notificationsEnabled = true,
    this.memberTier = 'عضو مميز',
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? avatarUrl,
    int? totalOrders,
    int? favoriteCount,
    double? walletBalance,
    bool? notificationsEnabled,
    String? memberTier,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      totalOrders: totalOrders ?? this.totalOrders,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      walletBalance: walletBalance ?? this.walletBalance,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      memberTier: memberTier ?? this.memberTier,
    );
  }

  /// Default mock user matching the reference design ("Thaer", "thaer@gmail.com")
  factory UserModel.defaultUser() {
    return const UserModel(
      id: 'usr_001',
      name: 'Thaer',
      email: 'thaer@gmail.com',
      phone: '+966 55 123 4567',
      address: 'شارع الملك فهد، حي النرجس، الرياض',
      totalOrders: 14,
      favoriteCount: 6,
      walletBalance: 145.50,
      notificationsEnabled: true,
      memberTier: 'عضو مميز (VIP)',
    );
  }
}
