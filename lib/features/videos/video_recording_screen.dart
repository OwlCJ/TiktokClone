import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';
import 'package:tiktok_clone/features/videos/widgets/flashmode_icon.dart';

final List flashButtons = [
  {
    "flashMode": FlashMode.off,
    "icon": Icons.flash_off_outlined,
  },
  {
    "flashMode": FlashMode.always,
    "icon": Icons.flash_on_outlined,
  },
  {
    "flashMode": FlashMode.auto,
    "icon": Icons.flash_auto_outlined,
  },
  {
    "flashMode": FlashMode.torch,
    "icon": Icons.flashlight_on_outlined,
  },
];

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  bool _hasPermission = false;
  bool _permissionDenied = false;

  bool _isSelfieMode = false;

  late final AnimationController _buttonAnimationConroller =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 150));

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationConroller);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late FlashMode _flashMode;
  late CameraController _cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
        cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.ultraHigh);

    await _cameraController.initialize();
    // this for Ios VideoSink
    await _cameraController.prepareForVideoRecording();
    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
    } else {
      _permissionDenied = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    // notification if animation finished
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationConroller.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationConroller.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(video: video),
      ),
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationConroller.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _permissionDenied
            ? const PermissionDenied()
            : !_hasPermission || !_cameraController.value.isInitialized
                ? const Initializing()
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      CameraPreview(_cameraController),
                      Positioned(
                        top: Sizes.size20,
                        right: Sizes.size10,
                        child: Column(
                          children: [
                            IconButton(
                              color: Colors.white,
                              onPressed: _toggleSelfieMode,
                              icon: const Icon(Icons.cameraswitch_outlined),
                            ),
                            Gaps.v10,
                            for (var flashButton in flashButtons)
                              FlashModeIcon(
                                isSelected:
                                    _flashMode == flashButton["flashMode"],
                                icon: flashButton["icon"],
                                flashMode: flashButton["flashMode"],
                                setFlashMode: _setFlashMode,
                              )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: Sizes.size40,
                        child: GestureDetector(
                          onTapDown: _startRecording,
                          onTapUp: (details) => _stopRecording(),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size60 + Sizes.size14,
                                  height: Sizes.size60 + Sizes.size14,
                                  child: CircularProgressIndicator(
                                    value: _progressAnimationController.value,
                                    color: Colors.red.shade500,
                                    strokeWidth: Sizes.size5,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size60,
                                  height: Sizes.size60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.shade500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
      ),
    );
  }
}

class PermissionDenied extends StatelessWidget {
  const PermissionDenied({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Permissions Denied",
          style: TextStyle(fontSize: Sizes.size18),
        ),
        Gaps.v20,
        Text(
          "Please Change Permissions on Settings",
          style: TextStyle(fontSize: Sizes.size16),
        ),
      ],
    );
  }
}

class Initializing extends StatelessWidget {
  const Initializing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Initializing...",
          style: TextStyle(fontSize: Sizes.size18),
        ),
        Gaps.v20,
        CircularProgressIndicator.adaptive(),
      ],
    );
  }
}
