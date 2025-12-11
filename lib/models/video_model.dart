import 'package:flutter/material.dart';

class VideoTutorial {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final Duration duration;
  final String platform; // 'youtube', 'instagram', 'tiktok', 'other'
  final DateTime uploadDate;
  final String recipeId;

  VideoTutorial({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.duration,
    required this.platform,
    required this.uploadDate,
    required this.recipeId,
  });

  factory VideoTutorial.fromJson(Map<String, dynamic> json) {
    return VideoTutorial(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      duration: Duration(seconds: json['duration'] ?? 0),
      platform: json['platform'] ?? 'other',
      uploadDate: DateTime.parse(json['uploadDate'] ?? DateTime.now().toIso8601String()),
      recipeId: json['recipeId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration.inSeconds,
      'platform': platform,
      'uploadDate': uploadDate.toIso8601String(),
      'recipeId': recipeId,
    };
  }

  // Helper untuk mendapatkan icon berdasarkan platform
  IconData get platformIcon {
    switch (platform.toLowerCase()) {
      case 'youtube':
        return Icons.play_circle_filled;
      case 'instagram':
        return Icons.camera_alt;
      case 'tiktok':
        return Icons.music_note;
      default:
        return Icons.video_library;
    }
  }

  Color get platformColor {
    switch (platform.toLowerCase()) {
      case 'youtube':
        return Colors.red;
      case 'instagram':
        return Colors.pink;
      case 'tiktok':
        return Colors.black;
      default:
        return Colors.blue;
    }
  }

  String get platformLabel {
    switch (platform.toLowerCase()) {
      case 'youtube':
        return 'YouTube';
      case 'instagram':
        return 'Instagram';
      case 'tiktok':
        return 'TikTok';
      default:
        return 'Video';
    }
  }
}