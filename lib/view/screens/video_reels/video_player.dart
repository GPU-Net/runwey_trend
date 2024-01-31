import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  final String videoUrl;


  ChewieListItem({required this.videoUrl,});

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isLoading = true;
  bool _isVideoBuffering = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);

    // Set up listener for video buffer state
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.isBuffering) {
        setState(() {
          _isVideoBuffering = true;
        });
      } else {
        setState(() {
          _isVideoBuffering = false;
        });
      }
    });

    await _videoPlayerController.initialize();

    setState(() {
      _isLoading = false;
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        looping: false,

        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        fullScreenByDefault: false,
        showOptions: false,
        allowedScreenSleep: false,allowMuting: false,zoomAndPan: false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_isVideoBuffering) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Chewie(controller: _chewieController),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}