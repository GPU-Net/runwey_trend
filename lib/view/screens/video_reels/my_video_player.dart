import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class MyVideoPlayer extends StatefulWidget {
  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    var headers = {
      'Accept': 'video/mp4',
      'Content-Type': 'video/mp4',
      'Range': 'bytes',
    };

    var response = await http.get(
      Uri.parse('http://192.168.10.15:3002/api/contents/videos/657922331eea37defe4b6527'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final videoBytes = response.bodyBytes;
      final tempVideoFile = await File('path/to/temp_video.mp4').writeAsBytes(videoBytes);
      // Initialize video player controller
      _videoPlayerController = VideoPlayerController.file(tempVideoFile);

      // Initialize Chewie controller
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: false, // Set autoPlay to false
        looping: true,
        showControls: false, // Set showControls to false
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );

      await _videoPlayerController.initialize();
      setState(() {});
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player Example'),
      ),
      body: _videoPlayerController.value.isInitialized
          ? Chewie(controller: _chewieController)
          : const Center(
        child: CircularProgressIndicator(),
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