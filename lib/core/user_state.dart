import 'package:flutter/material.dart';
import 'package:restaurant/models/user_model.dart';

/// Centralized User State Manager following Clean Architecture.
///
/// Uses [ValueNotifier<UserModel>] for lightweight, dependency-free reactive
/// state management across all screens and side drawers.
class UserState {
  static final ValueNotifier<UserModel> currentUser =
      ValueNotifier<UserModel>(UserModel.defaultUser());

  /// Returns whether the user is logged in
  static bool get isLoggedIn => currentUser.value.id.isNotEmpty;

  /// Updates user profile details
  static void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    currentUser.value = currentUser.value.copyWith(
      name: name,
      email: email,
      phone: phone,
      address: address,
    );
  }

  /// Toggles notifications setting
  static void setNotificationsEnabled(bool enabled) {
    currentUser.value = currentUser.value.copyWith(
      notificationsEnabled: enabled,
    );
  }

  /// Increment/decrement favorite count
  static void updateFavoriteCount(int delta) {
    final newCount = (currentUser.value.favoriteCount + delta).clamp(0, 9999);
    currentUser.value = currentUser.value.copyWith(
      favoriteCount: newCount,
    );
  }

  /// Log out action
  static void logout() {
    currentUser.value = const UserModel(
      id: '',
      name: 'ضيف',
      email: 'guest@app.com',
      phone: '',
      address: '',
      totalOrders: 0,
      favoriteCount: 0,
      walletBalance: 0,
    );
  }

  /// Resets back to default demo user
  static void resetToDefault() {
    currentUser.value = UserModel.defaultUser();
  }
}
