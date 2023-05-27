import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_profile_infobox.dart';

class UserprofileScreen extends StatefulWidget {
  const UserprofileScreen({super.key});

  @override
  State<UserprofileScreen> createState() => _UserprofileScreenState();
}

class _UserprofileScreenState extends State<UserprofileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text('Testing Users'),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.gear))
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      foregroundColor: Colors.teal,
                      foregroundImage: NetworkImage(
                          "https://avatars.githubusercontent.com/u/81318468?v=4"),
                      child: Text("CJ"),
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "@CJ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        Gaps.h5,
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          size: Sizes.size16,
                          color: Colors.blue.shade300,
                        ),
                      ],
                    ),
                    Gaps.v24,
                    SizedBox(
                      height: Sizes.size48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const UserProfileInfoBox(
                            value: "97",
                            type: "Following",
                          ),
                          VerticalDivider(
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade400,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),
                          const UserProfileInfoBox(
                            value: "10.7M",
                            type: "Followers",
                          ),
                          VerticalDivider(
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade400,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),
                          const UserProfileInfoBox(
                            value: "194.3M",
                            type: "Likes",
                          ),
                        ],
                      ),
                    ),
                    Gaps.v14,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Sizes.size4),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Follow',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Gaps.h4,
                        Container(
                          width: 54,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: const Center(
                              child: FaIcon(FontAwesomeIcons.youtube)),
                        ),
                        Gaps.h4,
                        Container(
                          width: 54,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.caretDown,
                              size: Sizes.size16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gaps.v14,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
                      child: Text(
                        "All highlights and where to watch live matches on FIFA+",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v14,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.link,
                          size: Sizes.size12,
                        ),
                        Gaps.h4,
                        Text(
                          'https://nomadcoders.co',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gaps.v5,
                      ],
                    ),
                    Gaps.v20,
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistentTabBar(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 20,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: Sizes.size2,
                  mainAxisSpacing: Sizes.size2,
                  childAspectRatio: 9 / 14,
                ),
                itemBuilder: (context, index) => Column(
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 9 / 14,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "assets/images/placeholder.jpg",
                            image:
                                "https://images.unsplash.com/photo-1577703451648-77e854069658?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                          ),
                        ),
                        const Positioned(
                          left: Sizes.size8,
                          bottom: Sizes.size4,
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.play,
                                color: Colors.white,
                                size: Sizes.size20,
                              ),
                              Gaps.h8,
                              Text(
                                '29.6K',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Center(
                child: Text('Page Two'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
