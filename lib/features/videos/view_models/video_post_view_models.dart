import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;
  late final String _videoId;

  @override
  FutureOr<void> build(String videoId) {
    _videoId = videoId;
    _repository = ref.read(videosRepo);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _repository.likeVideo(_videoId, user!.uid);
  }

  Future<bool> isLiked() async {
    final user = ref.read(authRepo).user;
    final isLiked = await _repository.isLiked(_videoId, user!.uid);
    return isLiked;
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
