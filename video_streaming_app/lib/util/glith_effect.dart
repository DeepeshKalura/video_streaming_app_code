import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

getRandomColor() => [
      const Color(0xFF782ce8),
      const Color(0xFF782ce8),
      const Color(0xFFc494f7),
      const Color(0xFF010101),
      const Color(0xFFFFFFFF),
      const Color(0xFF000000),
      const Color(0xFF1c1d1f),
      const Color(0xFF161616),
      const Color(0xFF3d3d3f),
      const Color(0xFF066162),
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][math.Random().nextInt(3)];

class GlithEffect extends StatefulWidget {
  const GlithEffect({super.key, required this.child});

  final Widget child;

  @override
  GlithEffectState createState() => GlithEffectState();
}

class GlithEffectState extends State<GlithEffect>
    with SingleTickerProviderStateMixin {
  late GlitchController _controller;
  late Timer _timer;

  @override
  void initState() {
    _controller = GlitchController(
      duration: const Duration(
        milliseconds: 400,
      ),
    );

    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        _controller
          ..reset()
          ..forward();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          var color = getRandomColor().withOpacity(0.5);
          if (!_controller.isAnimating) {
            return widget.child;
          }
          return Stack(
            children: [
              if (random.nextBool()) _clipedChild,
              Transform.translate(
                offset: randomOffset,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: <Color>[
                        color,
                        color,
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: _clipedChild,
                ),
              ),
            ],
          );
        });
  }

  Offset get randomOffset => Offset(
        (random.nextInt(10) - 5).toDouble(),
        (random.nextInt(10) - 5).toDouble(),
      );
  Widget get _clipedChild => ClipPath(
        clipper: GlitchClipper(),
        child: widget.child,
      );
}

var random = math.Random();

class GlitchClipper extends CustomClipper<Path> {
  final deltaMax = 15;
  final min = 3;

  @override
  getClip(Size size) {
    var path = Path();
    var y = randomStep;
    while (y < size.height) {
      var yRandom = randomStep;
      var x = randomStep;

      while (x < size.width) {
        var xRandom = randomStep;
        path.addRect(
          Rect.fromPoints(
            Offset(x, y.toDouble()),
            Offset(x + xRandom, y + yRandom),
          ),
        );
        x += randomStep * 2;
      }
      y += yRandom;
    }

    path.close();
    return path;
  }

  double get randomStep => min + random.nextInt(deltaMax).toDouble();

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class GlitchController extends Animation<int>
    with
        AnimationEagerListenerMixin,
        AnimationLocalListenersMixin,
        AnimationLocalStatusListenersMixin {
  GlitchController({
    required this.duration,
  });

  late Duration duration;
  late List<Timer> _timers = [];
  late bool isAnimating = false;

  forward() {
    isAnimating = true;
    var oneStep = (duration.inMicroseconds / 3).round();
    _status = AnimationStatus.forward;
    _timers = [
      Timer(
        Duration(microseconds: oneStep),
        () => setValue(1),
      ),
      Timer(
        Duration(microseconds: oneStep * 2),
        () => setValue(2),
      ),
      Timer(
        Duration(microseconds: oneStep * 3),
        () => setValue(3),
      ),
      Timer(
        Duration(microseconds: oneStep * 4),
        () {
          _status = AnimationStatus.completed;
          isAnimating = false;
          notifyListeners();
        },
      ),
    ];
  }

  setValue(value) {
    _value = value;
    notifyListeners();
  }

  reset() {
    _status = AnimationStatus.dismissed;
    _value = 0;
  }

  @override
  void dispose() {
    for (var timer in _timers) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  AnimationStatus get status => _status;
  late AnimationStatus _status;

  @override
  int get value => _value;
  late int _value;
}
