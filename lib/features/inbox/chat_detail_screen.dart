import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late final TextEditingController _textEditingController =
      TextEditingController();

  void _onTextFieldUnFocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Breakpoints.lg),
        child: Scaffold(
          appBar: AppBar(
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: Sizes.size8,
              leading: Stack(
                children: [
                  const CircleAvatar(
                    radius: Sizes.size24,
                    backgroundColor: Colors.black,
                    foregroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/81318468?v=4"),
                    child: Text("CJ"),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      height: Sizes.size18,
                      width: Sizes.size18,
                    ),
                  ),
                ],
              ),
              title: const Text(
                'CJ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text('Active now'),
              trailing: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    FontAwesomeIcons.flag,
                    size: Sizes.size20,
                  ),
                  Gaps.h24,
                  FaIcon(
                    FontAwesomeIcons.ellipsis,
                    size: Sizes.size20,
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              GestureDetector(
                onTap: _onTextFieldUnFocus,
                child: ListView.separated(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size20,
                    horizontal: Sizes.size14,
                  ),
                  itemBuilder: (context, index) {
                    final isMine = index % 2 == 0;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: isMine
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Sizes.size14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(Sizes.size16),
                              topRight: const Radius.circular(Sizes.size16),
                              bottomLeft: Radius.circular(
                                  isMine ? Sizes.size16 : Sizes.size5),
                              bottomRight: Radius.circular(
                                  !isMine ? Sizes.size16 : Sizes.size4),
                            ),
                            color: isMine
                                ? Colors.blue
                                : Theme.of(context).primaryColor,
                          ),
                          child: const Text(
                            'This is a message',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size16,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Gaps.v10,
                  itemCount: 10,
                ),
              ),
              Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                child: BottomAppBar(
                  padding: const EdgeInsets.all(Sizes.size12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Sizes.size20),
                              topRight: Radius.circular(Sizes.size20),
                              bottomLeft: Radius.circular(Sizes.size20),
                            ),
                          ),
                          child: TextField(
                            controller: _textEditingController,
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              hintText: "Send a message...",
                              filled: true,
                              border: InputBorder.none,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.faceLaugh,
                                      color: isDark ? null : Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.h14,
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey.shade800 : Colors.black12,
                          borderRadius: BorderRadius.circular(21),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.paperPlane,
                            color: isDark ? Colors.grey.shade500 : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
