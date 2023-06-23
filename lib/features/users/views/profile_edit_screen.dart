import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: const SingleChildScrollView(
          child: Column(
        children: [
          TextField(),
          TextField(),
        ],
      )),
    );
  }
}
