import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/widgets/auth/login.dart';
import 'package:pizza_time/widgets/auth/register.dart';
import 'package:pizza_time/widgets/background_painter/background_painter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const AuthPage(),
      );

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller,
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ValueListenableBuilder<bool>(
                valueListenable: showSignInPage,
                builder: (context, value, child) {
                  return SizedBox.expand(
                    child: PageTransitionSwitcher(
                      reverse: !value,
                      duration: const Duration(milliseconds: 800),
                      transitionBuilder:
                          (child, animation, secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.vertical,
                          fillColor: Colors.transparent,
                          child: child,
                        );
                      },
                      child: value
                          ? SignIn(
                              key: const ValueKey('SignIn'),
                              onRegisterClicked: () {
                                // context.resetSignInForm();
                                showSignInPage.value = false;
                                _controller.forward();
                              },
                            )
                          : Register(
                              key: const ValueKey('Register'),
                              onSignInPressed: () {
                                //context.resetSignInForm();
                                showSignInPage.value = true;
                                _controller.reverse();
                              },
                            ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
