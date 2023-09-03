import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../theme/colors.dart';
import 'browser_screen.dart';
import 'discovery_screen.dart';
import 'following_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: getAppBar(),
      ),
      bottomNavigationBar: getTab(),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: bgColor,
      leading: IconButton(
        onPressed: () {},
        icon: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: white.withOpacity(0.7),
          ),
          child: const Center(
            child: Icon(
              // AntDesign.user,
              IonIcons.person,
              color: black,
              size: 20,
            ),
          ),
        ),
      ),
      actions: const [
        IconButton(
          onPressed: null,
          icon: Icon(
            // AntDesign.wifi,
            IonIcons.wifi,
            color: white,
            size: 22,
          ),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(
            // AntDesign.videocamera,
            IonIcons.videocam,
            color: white,
            size: 22,
          ),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(
            // AntDesign.inbox,
            Iconsax.direct_inbox,
            color: white,
            size: 25,
          ),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(
            // MaterialCommunityIcons.comment_outline,
            IonIcons.chatbubble_ellipses,
            color: white,
            size: 22,
          ),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(
            // AntDesign.search1,
            IonIcons.search,
            color: white,
            size: 22,
          ),
        )
      ],
    );
  }

  Widget getTab() {
    List iconItems = [
      // MaterialCommunityIcons.cards_heart,
      IonIcons.heart_circle_sharp,
      // MaterialCommunityIcons.compass,
      IonIcons.compass,
      IonIcons.copy,
    ];
    List textItems = [
      "Following",
      "Discover",
      "Browser",
    ];
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: white.withOpacity(0.2),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            iconItems.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      pageIndex = index;
                    },
                  );
                },
                child: Column(
                  children: [
                    Icon(
                      iconItems[index],
                      size: 30,
                      color: pageIndex == index
                          ? secondary
                          : white.withOpacity(0.5),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      textItems[index],
                      style: TextStyle(
                        color: pageIndex == index
                            ? secondary
                            : white.withOpacity(0.5),
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        FollowingScreen(),
        DiscoverScreen(),
        BrowseScreen(),
      ],
    );
  }
}
