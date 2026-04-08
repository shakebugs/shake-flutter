import 'package:flutter/cupertino.dart';
import 'package:shake_flutter/models/shake_theme.dart';
import 'package:shake_flutter/shake_flutter.dart';

class DarkModeObserver extends StatefulWidget {
  final Widget child;

  DarkModeObserver({required this.child});

  @override
  _DarkModeObserverState createState() => _DarkModeObserverState();
}

class _DarkModeObserverState extends State<DarkModeObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => setShakeTheme());
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setShakeTheme();
  }

  void setShakeTheme() {
    Brightness currentBrightness =
        View.of(context).platformDispatcher.platformBrightness;
    if (currentBrightness == Brightness.dark) {
      ShakeTheme darkTheme = ShakeTheme();
      Shake.setShakeTheme(darkTheme);
    } else {
      ShakeTheme lightTheme = ShakeTheme();
      Shake.setShakeTheme(lightTheme);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
