import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../utils/helpers.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final double? aspectRatio;

  const CustomVideoPlayer({
    Key? key,
    required this.videoUrl,
    this.autoPlay = true,
    this.looping = false,
    this.showControls = true,
    this.aspectRatio,
  }) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;
  double? _aspectRatio;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
      
      await _videoPlayerController.initialize();
      
      // Get aspect ratio from video controller
      final videoSize = _videoPlayerController.value.size;
      _aspectRatio = videoSize.width / videoSize.height;
      
      // Use provided aspect ratio or calculated one
      final aspectRatio = widget.aspectRatio ?? _aspectRatio ?? 16/9;
      
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        aspectRatio: aspectRatio,
        autoInitialize: true,
        allowFullScreen: true,
        allowMuting: true,
        showControls: widget.showControls,
        placeholder: Container(
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.grey.withOpacity(0.5),
        ),
        errorBuilder: (context, errorMessage) {
          return Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.white, size: 50),
                  SizedBox(height: 16),
                  Text(
                    'Gagal memuat video',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      );

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Error initializing video player: $e');
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _buildErrorWidget();
    }

    if (!_isInitialized || _chewieController == null) {
      return _buildLoadingWidget();
    }

    // Get aspect ratio, default to 16:9 if null
    final aspectRatio = _chewieController!.aspectRatio ?? _aspectRatio ?? 16/9;
    
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Chewie(controller: _chewieController!),
    );
  }

  Widget _buildLoadingWidget() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 16),
              Text(
                'Memuat video...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.videocam_off, color: Colors.white, size: 50),
              SizedBox(height: 16),
              Text(
                'Video tidak dapat diputar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Pastikan koneksi internet stabil atau coba video lain',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _hasError = false;
                  });
                  _initializeVideoPlayer();
                },
                icon: Icon(Icons.refresh),
                label: Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}

// Mini Video Player untuk thumbnail
class MiniVideoPlayer extends StatelessWidget {
  final String videoUrl;
  final String thumbnailUrl;
  final VoidCallback onTap;
  final bool showPlayButton;

  const MiniVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.onTap,
    this.showPlayButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Thumbnail
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(thumbnailUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Overlay gelap
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          
          // Play button
          if (showPlayButton)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.red,
                size: 40,
              ),
            ),
          
          // Platform badge
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.videocam, color: Colors.white, size: 12),
                  SizedBox(width: 4),
                  Text(
                    Helpers.detectVideoPlatform(videoUrl) == 'youtube'
                        ? 'YouTube'
                        : 'Video',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}