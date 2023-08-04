import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/views/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  static const String routeName = "chats";
  static const String routeURL = "/chats";
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(0);
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Container(
            color: Colors.red,
            child: _makeTile(index),
          ),
        ),
      );
    }
  }

  void _onChatTap(int index) {
    context.pushNamed(
      ChatDetailScreen.routeName,
      params: {"chatId": "$index"},
    );
  }

  ListTile _makeTile(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: () => _onChatTap(index),
      leading: const CircleAvatar(
        foregroundImage: NetworkImage(
            "https://avatars.githubusercontent.com/u/81318468?v=4"),
        radius: 30,
        backgroundColor: Colors.black,
      ),
      title: Text(
        'Lynn ($index)',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: const Text("Don't forget to Coding"),
      trailing: Text(
        '4:56 AM',
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: Sizes.size12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Breakpoints.lg),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Direct messages'),
            actions: [
              IconButton(
                enableFeedback: false,
                onPressed: _addItem,
                icon: const FaIcon(
                  FontAwesomeIcons.plus,
                ),
              ),
            ],
          ),
          body: AnimatedList(
            key: _key,
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10,
            ),
            itemBuilder: (context, index, animation) {
              return FadeTransition(
                key: UniqueKey(),
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: _makeTile(index),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
