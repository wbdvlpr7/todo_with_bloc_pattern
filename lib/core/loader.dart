import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GLoader extends StatelessWidget {
  const GLoader({
    Key? key,
    this.color,
    this.size = 50.0,
    this.type = LType.fadingCircle,
  }) : super(key: key);
  final Color? color;
  final double size;
  final LType type;
  @override
  Widget build(BuildContext context) {
    late Widget loader;
    final color =
        this.color ?? Theme.of(context).colorScheme.secondary.withOpacity(0.7);
    switch (type) {
      case LType.doubleBounce:
        loader = SpinKitDoubleBounce(color: color, size: size);
        break;
      case LType.dualRing:
        loader = SpinKitDualRing(color: color, size: size);
        break;
      case LType.fadingGrid:
        loader = SpinKitFadingGrid(color: color, size: size);
        break;
      case LType.fadingCircle:
        loader = SpinKitFadingCircle(color: color, size: size);
        break;
      case LType.spinningLines:
        loader = SpinKitSpinningLines(color: color, size: size);
        break;
      case LType.ring:
        loader = SpinKitRing(color: color, size: size);
        break;
      case LType.ripple:
        loader = SpinKitRipple(color: color, size: size);
        break;
      case LType.threeBounce:
        loader = SpinKitThreeBounce(color: color, size: size);
        break;
      case LType.pulse:
        loader = SpinKitPulse(color: color, size: size);
        break;
      case LType.threeInOut:
        loader = SpinKitThreeInOut(color: color, size: size);
        break;
      case LType.rotatingCircle:
        loader = SpinKitRotatingCircle(color: color, size: size);
        break;
      default:
    }
    return SizedBox(width: size, height: size, child: loader);
  }
}

enum LType {
  doubleBounce,
  dualRing,
  fadingGrid,
  fadingCircle,
  spinningLines,
  ring,
  ripple,
  threeBounce,
  pulse,
  threeInOut,
  rotatingCircle,
}
