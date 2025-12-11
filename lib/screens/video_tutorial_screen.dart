import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/recipe_model.dart';
import '../utils/helpers.dart';
import '../utils/constants.dart';
import '../widgets/video_player_widget.dart';

class VideoTutorialScreen extends StatefulWidget {
  final String videoUrl;
  final String recipeTitle;
  final Recipe? recipe;

  VideoTutorialScreen({
    required this.videoUrl,
    required this.recipeTitle,
    this.recipe,
  });

  @override
  _VideoTutorialScreenState createState() => _VideoTutorialScreenState();
}

class _VideoTutorialScreenState extends State<VideoTutorialScreen> {
  bool _isYoutube = false;
  late String _detectedPlatform;

  @override
  void initState() {
    super.initState();
    _detectedPlatform = Helpers.detectVideoPlatform(widget.videoUrl);
    _isYoutube = _detectedPlatform == 'youtube';
  }

  void _openInBrowser() {
    Helpers.launchExternalUrl(widget.videoUrl);
  }

  IconData _getPlatformIcon() {
    switch (_detectedPlatform) {
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

  Color _getPlatformColor() {
    switch (_detectedPlatform) {
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

  String _getPlatformLabel() {
    switch (_detectedPlatform) {
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

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Chip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(text),
      backgroundColor: color.withOpacity(0.1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Tutorial'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul Resep
            Padding(
              padding: EdgeInsets.all(AppConstants.defaultPadding),
              child: Text(
                widget.recipeTitle,
                style: AppConstants.heading1,
              ),
            ),
            
            // Video Player
            _isYoutube
                ? _buildYoutubeSection()
                : _buildVideoPlayerSection(),
            
            // Info Platform
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Icon(
                    _getPlatformIcon(),
                    color: _getPlatformColor(),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Video dari ${_getPlatformLabel()}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            // Tombol Aksi
            if (_isYoutube)
              Padding(
                padding: EdgeInsets.all(AppConstants.defaultPadding),
                child: ElevatedButton.icon(
                  onPressed: _openInBrowser,
                  icon: Icon(Icons.open_in_new),
                  label: Text('Buka di ${_getPlatformLabel()}'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: _getPlatformColor(),
                  ),
                ),
              ),
            
            // Info tambahan jika ada resep
            if (widget.recipe != null) _buildRecipeInfo(),
            
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildYoutubeSection() {
    final thumbnailUrl = Helpers.getYoutubeThumbnail(widget.videoUrl);
    
    return Container(
      margin: EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        child: Stack(
          children: [
            // Thumbnail
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnailUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Overlay
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
            
            // Play button overlay
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _openInBrowser,
                  splashColor: Colors.red.withOpacity(0.3),
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayerSection() {
    return Padding(
      padding: EdgeInsets.all(AppConstants.defaultPadding),
      child: CustomVideoPlayer(
        videoUrl: widget.videoUrl,
        autoPlay: false,
        showControls: true,
      ),
    );
  }

  Widget _buildRecipeInfo() {
    final recipe = widget.recipe!;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: 16),
          
          Text(
            'Informasi Resep',
            style: AppConstants.heading3,
          ),
          SizedBox(height: 12),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildInfoChip(
                Icons.timer,
                '${recipe.cookingTime} menit',
                Colors.blue,
              ),
              _buildInfoChip(
                Icons.bar_chart,
                recipe.difficulty,
                Colors.orange,
              ),
              _buildInfoChip(
                Icons.category,
                recipe.category,
                Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }
}