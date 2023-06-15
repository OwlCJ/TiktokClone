import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.lg),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: ListView(
              children: [
                SwitchListTile.adaptive(
                  value: ref.watch(plyabackConfigProvider).muted,
                  onChanged: (value) =>
                      ref.read(plyabackConfigProvider.notifier).setMuted(value),
                  title: const Text("Mute Video"),
                  subtitle: const Text("Video will be muted by default."),
                ),
                SwitchListTile.adaptive(
                  value: ref.watch(plyabackConfigProvider).autoplay,
                  onChanged: (value) => ref
                      .read(plyabackConfigProvider.notifier)
                      .setAutoplay(value),
                  title: const Text("AutoPlay"),
                  subtitle:
                      const Text("Video will start playing automatically."),
                ),
                ValueListenableBuilder(
                  valueListenable: darkMode,
                  builder: (context, value, child) => SwitchListTile.adaptive(
                    value: value,
                    onChanged: (value) {
                      darkMode.value = !darkMode.value;
                    },
                    title: const Text("DarkTheme Mode"),
                    subtitle: const Text("Change app's theme Light/Dark"),
                  ),
                ),
                SwitchListTile.adaptive(
                  value: false,
                  onChanged: (value) {},
                  title: const Text("Enable notifications"),
                  subtitle: const Text("They will be cute."),
                ),
                CheckboxListTile(
                  value: false,
                  activeColor: Colors.black,
                  onChanged: (value) {},
                  title: const Text("Marketing emails"),
                  subtitle: const Text("We won't spam you."),
                ),
                // ListTile(
                //   onTap: () async {
                //     final date = await showDatePicker(
                //       context: context,
                //       initialDate: DateTime.now(),
                //       firstDate: DateTime(1980),
                //       lastDate: DateTime(2030),
                //     );
                //     final time = await showTimePicker(
                //       context: context,
                //       initialTime: TimeOfDay.now(),
                //     );
                //     final booking = await showDateRangePicker(
                //       context: context,
                //       firstDate: DateTime(1980),
                //       lastDate: DateTime(2030),
                //       builder: (context, child) {
                //         return Theme(
                //           data: ThemeData(
                //               appBarTheme: const AppBarTheme(
                //                   foregroundColor: Colors.white,
                //                   backgroundColor: Colors.black)),
                //           child: child!,
                //         );
                //       },
                //     );
                //   },
                //   title: const Text("What is your birthday?"),
                //   subtitle: const Text("I need to know!"),
                // ),
                ListTile(
                  title: const Text("Log out (iOS)"),
                  textColor: Colors.red,
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text("Are you sure?"),
                        content: const Text("Plx dont go"),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("No"),
                          ),
                          CupertinoDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            isDestructiveAction: true,
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Log out (Android)"),
                  textColor: Colors.red,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const FaIcon(FontAwesomeIcons.skull),
                        title: const Text("Are you sure?"),
                        content: const Text("Plx dont go"),
                        actions: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const FaIcon(FontAwesomeIcons.car),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Log out (iOS / Bottom)"),
                  textColor: Colors.red,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: const Text("Are you sure?"),
                        message: const Text("Please dooooont gooooo"),
                        actions: [
                          CupertinoActionSheetAction(
                            isDefaultAction: true,
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Not log out"),
                          ),
                          CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Yes plz."),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const AboutListTile(
                  applicationVersion: "1.0",
                  applicationLegalese: "Don't copy me.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
