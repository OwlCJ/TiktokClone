import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/view_models/video_post_view_models.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_social_button.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;
  final VideoModel videoData;

  const VideoPost({
    super.key,
    required this.videoData,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  final Duration _animationDuration = const Duration(milliseconds: 200);
  late final AnimationController _animationController;
  bool _isPaused = false;
  late int _likesCount = widget.videoData.likes;
  late bool _isLiked = false;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      //비디오의 길이와 유저의 영상 위치가 같다면 다 본 것과 같음
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/video.mov");
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  void _initIsLiked() async {
    _isLiked = await ref
        .read(videoPostProvider(widget.videoData.id).notifier)
        .isLiked();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _initIsLiked();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );

    _onPlaybackMutedInitialize();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // 위젯트리에 init이 완료되었는지 확인하고 실행
    // dispose가 됬을 때 videoPlayerController에 참조해 에러발생
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(plyabackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onToggleVideo();
    }
  }

  void _onToggleVideo() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();

      setState(() {
        _isPaused = true;
      });
    } else {
      _videoPlayerController.play();
      _animationController.forward();

      setState(() {
        _isPaused = false;
      });
    }
  }

  void _onCommentsTap() async {
    if (_videoPlayerController.value.isPlaying) {
      _onToggleVideo();
    }
    await showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: Breakpoints.md),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const VideoComments(),
    );
    _onToggleVideo();
  }

  void _onVideoVolumeToggle() {
    if (!mounted) return;
    final muted = ref.read(plyabackConfigProvider).muted;
    if (muted) {
      _videoPlayerController.setVolume(1);
    } else {
      _videoPlayerController.setVolume(0);
    }
    ref.read(plyabackConfigProvider.notifier).setMuted(!muted);
  }

  void _onLikeTap() {
    if (_isLiked) {
      _isLiked = false;
      _likesCount -= 1;
    } else {
      _isLiked = true;
      _likesCount += 1;
    }
    setState(() {});
    ref.read(videoPostProvider(widget.videoData.id).notifier).likeVideo();
  }

  void _onPlaybackMutedInitialize() {
    if (!mounted) return;
    if (ref.read(plyabackConfigProvider).muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: _videoPlayerController.value.isInitialized
                  ? VideoPlayer(_videoPlayerController)
                  : Container(
                      color: Colors.black,
                      child: const CircularProgressIndicator(),
                    ),
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onToggleVideo,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${widget.videoData.creator}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  widget.videoData.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  radius: 25,
                  foregroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/owlcj-tiktok-clone.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media"),
                  child: Text(widget.videoData.creator),
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onLikeTap,
                  child: VideoSocialButton(
                    icon: FontAwesomeIcons.solidHeart,
                    text: "$_likesCount",
                    color: _isLiked ? Colors.red : Colors.white,
                  ),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onCommentsTap,
                  child: VideoSocialButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "${widget.videoData.comments}",
                    color: Colors.white,
                  ),
                ),
                Gaps.v24,
                const VideoSocialButton(
                  icon: FontAwesomeIcons.share,
                  text: "2.9M",
                  color: Colors.white,
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onVideoVolumeToggle,
                  child: VideoSocialButton(
                    icon: ref.watch(plyabackConfigProvider).muted
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volumeHigh,
                    text: "",
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
