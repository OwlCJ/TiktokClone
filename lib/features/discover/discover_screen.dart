import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late TextEditingController _textEditingController;
  late bool _isSearching = false;

  // void _onSearchSubmitted(String value) {}

  void _onSearchChanged(String value) {}

  void _onTabBarUnFocus(int idx) {
    FocusScope.of(context).unfocus();
  }

  void _handleIsSearching() {
    if (_textEditingController.text.isEmpty) {
      _isSearching = false;
    } else {
      _isSearching = true;
    }
    setState(() {});
  }

  void _onSearchClearTap() {
    _textEditingController.clear();
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_handleIsSearching);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.lg),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizes.size7)),
                child: TextField(
                  onChanged: _onSearchChanged,
                  controller: _textEditingController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                    ),
                    fillColor:
                        isDarkMode(context) ? null : Colors.grey.shade200,
                    filled: true,
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: Sizes.size20,
                            color: Colors.grey.shade500,
                          ),
                        ],
                      ),
                    ),
                    suffixIcon: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isSearching)
                            GestureDetector(
                              onTap: _onSearchClearTap,
                              child: FaIcon(
                                FontAwesomeIcons.solidCircleXmark,
                                size: Sizes.size20,
                                color: Colors.grey.shade500,
                              ),
                            ),
                        ],
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              bottom: TabBar(
                onTap: _onTabBarUnFocus,
                splashFactory: NoSplash.splashFactory,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                ),
                isScrollable: true,
                labelStyle: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
                indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
                tabs: [
                  for (var tab in tabs)
                    Tab(
                      text: tab,
                    ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                GridView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 20,
                  padding: const EdgeInsets.all(Sizes.size6),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width > Breakpoints.lg ? 4 : 2,
                    crossAxisSpacing: Sizes.size14,
                    mainAxisSpacing: Sizes.size10,
                    childAspectRatio: 9 / 20,
                  ),
                  itemBuilder: (context, index) => Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                          Sizes.size4,
                        )),
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "assets/images/placeholder.jpg",
                            image:
                                "https://images.unsplash.com/photo-1577703451648-77e854069658?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                          ),
                        ),
                      ),
                      Gaps.v10,
                      const Text(
                        "This is a very long caption for my tiktok that im upload just now currently.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v8,
                      DefaultTextStyle(
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.grey.shade300
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                  "https://avatars.githubusercontent.com/u/81318468?v=4"),
                            ),
                            Gaps.h4,
                            const Expanded(
                              child: Text(
                                "My avatar is going to be very looong",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h2,
                            const Text("2.5M"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                for (var tab in tabs.skip(1))
                  Center(
                    child: Text(
                      tab,
                      style: const TextStyle(
                        fontSize: Sizes.size28,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
