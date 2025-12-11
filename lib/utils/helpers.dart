import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../models/video_model.dart';
import 'constants.dart';

class Helpers {
  // Format tanggal menjadi string yang mudah dibaca
  static String formatDate(DateTime date, {bool includeTime = true}) {
    if (includeTime) {
      return DateFormat('dd MMM yyyy, HH:mm').format(date);
    } else {
      return DateFormat('dd MMM yyyy').format(date);
    }
  }

  // Format durasi menjadi string menit:detik
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }

  // Format waktu relatif (e.g., "2 jam lalu")
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} tahun lalu';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} bulan lalu';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} hari lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit lalu';
    } else {
      return 'Baru saja';
    }
  }

  // Deteksi platform video dari URL
  static String detectVideoPlatform(String url) {
    final lowercaseUrl = url.toLowerCase();
    
    for (final pattern in AppConstants.youtubePatterns) {
      if (lowercaseUrl.contains(pattern)) return 'youtube';
    }
    
    for (final pattern in AppConstants.instagramPatterns) {
      if (lowercaseUrl.contains(pattern)) return 'instagram';
    }
    
    for (final pattern in AppConstants.tiktokPatterns) {
      if (lowercaseUrl.contains(pattern)) return 'tiktok';
    }
    
    return 'other';
  }

  // Ekstrak video ID dari URL YouTube
  static String? extractYoutubeId(String url) {
    final regExp = RegExp(
      r'^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
      caseSensitive: false,
    );
    
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }
    return null;
  }

  // Generate thumbnail URL untuk YouTube
  static String getYoutubeThumbnail(String url) {
    final videoId = extractYoutubeId(url);
    if (videoId != null) {
      return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
    }
    return AppConstants.defaultVideoThumbnail;
  }

  // Buka URL di browser eksternal
  static Future<void> launchExternalUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  // Validasi email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  // Validasi password (min 6 karakter)
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // Show snackbar dengan pesan
  static void showSnackbar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : AppConstants.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
      ),
    );
  }

  // Show loading dialog
  static void showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text(message),
          ],
        ),
      ),
    );
  }

  // Show confirmation dialog
  static Future<bool> showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Ya', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }

  // Get aspect ratio untuk video
  static double getVideoAspectRatio(VideoPlayerController controller) {
    final size = controller.value.size;
    return size.width / size.height;
  }

  // Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Truncate text dengan ellipsis
  static String truncateWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // Format angka menjadi format ribuan
  static String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  // Get color berdasarkan waktu (untuk planner)
  static Color getTimeColor(DateTime time) {
    final now = DateTime.now();
    final difference = time.difference(now);
    
    if (difference.inMinutes <= 0) {
      return Colors.red; // Waktu sudah lewat
    } else if (difference.inMinutes <= 30) {
      return Colors.orange; // Kurang dari 30 menit
    } else if (difference.inHours <= 1) {
      return Colors.yellow[700]!; // Kurang dari 1 jam
    } else {
      return Colors.green; // Masih lama
    }
  }
}