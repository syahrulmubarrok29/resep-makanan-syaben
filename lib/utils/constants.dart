import 'package:flutter/material.dart';

class AppConstants {
  // API Constants
  static const String apiBaseUrl = 'https://your-api-url.com/api';
  static const String recipesEndpoint = '/recipes';
  static const String plannersEndpoint = '/planners';
  static const String videosEndpoint = '/videos';
  
  // App Constants
  static const String appName = 'Food Recipe App';
  static const String appVersion = '1.0.0';
  
  // Colors
  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color secondaryColor = Color(0xFF2196F3);
  static const Color accentColor = Color(0xFFFF9800);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF333333);
  static const Color textSecondaryColor = Color(0xFF666666);
  
  // Text Styles
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textColor,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textColor,
  );
  
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textColor,
  );
  
  static const TextStyle bodyTextSecondary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondaryColor,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  
  // Spacing
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
  static const double defaultRadius = 12.0;
  
  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  
  // Notification Constants
  static const String notificationChannelId = 'cooking_channel';
  static const String notificationChannelName = 'Cooking Reminders';
  static const String notificationChannelDescription = 'Notifications for cooking schedules';
  
  // Local Storage Keys
  static const String storagePlannersKey = 'planners';
  static const String storageRecipesKey = 'recipes';
  static const String storageVideosKey = 'videos';
  static const String storageSettingsKey = 'settings';
  
  // Default Images
  static const String defaultRecipeImage = 'https://via.placeholder.com/300x200/4CAF50/FFFFFF?text=No+Image';
  static const String defaultVideoThumbnail = 'https://via.placeholder.com/300x200/2196F3/FFFFFF?text=Video+Tutorial';
  static const String defaultAvatar = 'https://via.placeholder.com/100/4CAF50/FFFFFF?text=User';
  
  // Social Media Patterns
  static const List<String> youtubePatterns = [
    'youtube.com',
    'youtu.be',
    'youtube.com/watch',
    'youtube.com/shorts'
  ];
  
  static const List<String> instagramPatterns = [
    'instagram.com',
    'instagr.am',
    'instagram.com/reel'
  ];
  
  static const List<String> tiktokPatterns = [
    'tiktok.com',
    'tiktok.com/@',
    'tiktok.com/video'
  ];
}

// API Response Constants
class ApiResponse {
  static const String success = 'success';
  static const String error = 'error';
  static const String loading = 'loading';
  
  static const int successCode = 200;
  static const int createdCode = 201;
  static const int badRequestCode = 400;
  static const int unauthorizedCode = 401;
  static const int notFoundCode = 404;
  static const int serverErrorCode = 500;
}

// Difficulty Levels
class DifficultyLevels {
  static const String easy = 'Mudah';
  static const String medium = 'Sedang';
  static const String hard = 'Sulit';
  
  static Color getColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'mudah':
      case 'easy':
        return Colors.green;
      case 'sedang':
      case 'medium':
        return Colors.orange;
      case 'sulit':
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  
  static IconData getIcon(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'mudah':
      case 'easy':
        return Icons.sentiment_satisfied;
      case 'sedang':
      case 'medium':
        return Icons.sentiment_neutral;
      case 'sulit':
      case 'hard':
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.help;
    }
  }
}

// Cooking Categories
class Categories {
  static const List<String> all = [
    'Semua',
    'Main Course',
    'Appetizer',
    'Dessert',
    'Minuman',
    'Sarapan',
    'Camilan',
    'Vegetarian',
    'Seafood',
    'Ayam',
    'Daging',
  ];
  
  static IconData getIcon(String category) {
    switch (category.toLowerCase()) {
      case 'main course':
        return Icons.restaurant;
      case 'appetizer':
        return Icons.fastfood;
      case 'dessert':
        return Icons.cake;
      case 'minuman':
        return Icons.local_drink;
      case 'sarapan':
        return Icons.breakfast_dining;
      case 'camilan':
        return Icons.emoji_food_beverage;
      case 'vegetarian':
        return Icons.eco;
      case 'seafood':
        return Icons.set_meal;
      case 'ayam':
        return Icons.kitchen;
      case 'daging':
        return Icons.grass;
      default:
        return Icons.category;
    }
  }
  
  static Color getColor(String category) {
    switch (category.toLowerCase()) {
      case 'main course':
        return Colors.amber;
      case 'appetizer':
        return Colors.lightBlue;
      case 'dessert':
        return Colors.pink;
      case 'minuman':
        return Colors.cyan;
      case 'sarapan':
        return Colors.orange;
      case 'camilan':
        return Colors.lightGreen;
      case 'vegetarian':
        return Colors.green;
      case 'seafood':
        return Colors.blue;
      case 'ayam':
        return Colors.brown;
      case 'daging':
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
  }
}