import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
// import 'package:flutter_icons/flutter_icons.dart';

import 'package:video_player/video_player.dart';

import '../../util/colors.dart';

class LiveStreamingScreen extends StatefulWidget {
  final List tags;
  final String name;
  final String profile;
  final String title;
  final String type;
  final String viewers;
  final String videoUrl;
  const LiveStreamingScreen(
      {Key? key,
      required this.tags,
      required this.name,
      required this.profile,
      required this.title,
      required this.type,
      required this.viewers,
      required this.videoUrl})
      : super(key: key);

  @override
  State<LiveStreamingScreen> createState() => _LiveStreamingScreenState();
}

class _LiveStreamingScreenState extends State<LiveStreamingScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((value) {
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: white.withOpacity(0.15)))),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 15),
        child: Row(
          children: [
            Container(
              width: size.width * 0.85,
              height: 45,
              decoration: BoxDecoration(
                  color: white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.65,
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        cursorColor: white.withOpacity(0.5),
                        style: TextStyle(color: white.withOpacity(0.5)),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Send a message",
                            hintStyle:
                                TextStyle(color: white.withOpacity(0.5))),
                      ),
                    ),
                  ),
                  Flexible(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(
                        FontAwesome.diamond,
                        // MaterialCommunityIcons.diamond_outline,
                        color: white,
                      ),
                      Icon(
                        Iconsax.emoji_happy,

                        // MaterialCommunityIcons.emoticon_excited_outline,
                        color: white,
                      ),
                    ],
                  ))
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    BoxIcons.bx_dots_vertical,

                    // Entypo.dots_three_vertical,
                    color: white.withOpacity(0.5),
                    size: 20,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: Column(
        children: [
          getVideoSection(),
          Expanded(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getProfileSection(),
                Divider(
                  thickness: 0.8,
                  color: white.withOpacity(0.15),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text(
                    "CHAT",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: white),
                  ),
                ),
                Divider(
                  thickness: 0.8,
                  color: white.withOpacity(0.15),
                ),
                getGiftSection()
              ],
            ),
          ))
        ],
      ),
    );
    // var size = MediaQuery.of(context).size;
  }

  Widget getVideoSection() {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.28,
      child: Stack(
        children: [getVideoPlayer(), getIconsSection()],
      ),
    );
  }

  Widget getVideoPlayer() {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.28,
      decoration: const BoxDecoration(color: primary),
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    );
  }

  Widget getIconsSection() {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.28,
      decoration: BoxDecoration(color: black.withOpacity(0.2)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: white,
                      size: 20,
                    )),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          IonIcons.share,
                          // Entypo.share_alternative,
                          color: white,
                          size: 20,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          LineAwesome.video_solid,
                          // Entypo.video,
                          color: white,
                        )),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IonIcons.settings,
                        // Feather.settings,
                        color: white,
                        size: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                        color: Colors.redAccent, shape: BoxShape.circle),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Live",
                    style: TextStyle(color: white),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${widget.viewers} viewers",
                    style: const TextStyle(color: white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getProfileSection() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50 / 2),
                child: Image.network(
                  widget.profile,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              width: 15,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, color: white),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  widget.title,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: white.withOpacity(0.5)),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  widget.type,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: white.withOpacity(0.5)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: List.generate(widget.tags.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 2, bottom: 2),
                          child: Text(
                            widget.tags[index],
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: white.withOpacity(0.7)),
                          ),
                        ),
                      ),
                    );
                  }),
                )
              ],
            )),
            const SizedBox(
              width: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  color: primary, borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Follow",
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getGiftSection() {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      decoration: BoxDecoration(color: white.withOpacity(0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: (size.width - 24) / 3,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/medal_1.png",
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "EzrasMonkey",
                      style: TextStyle(fontSize: 13, color: white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/diamond.png",
                          width: 15,
                          height: 15,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          "250",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: white.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: (size.width - 24) / 3,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/medal_2.png",
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Image.asset(
                      "assets/images/diamond.png",
                      width: 15,
                      height: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "HairDoa",
                      style: TextStyle(fontSize: 13, color: white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "100",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: white.withOpacity(0.7),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: (size.width - 24) / 3,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/medal_3.png",
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Image.asset(
                      "assets/images/diamond.png",
                      width: 15,
                      height: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Mahdmahx",
                      style: TextStyle(fontSize: 13, color: white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "100",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: white.withOpacity(0.7),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
