import 'package:flutter/material.dart';
import 'package:pizza_time/widgets/buttons/default/button_default.dart';

class SignIn extends StatelessWidget {
  const SignIn({
    Key? key,
    required this.onRegisterClicked,
  }) : super(key: key);

  final VoidCallback onRegisterClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonDefault(
        onPress: onRegisterClicked,
        child: Text("Go to reg"),
      ),
    );
  }
}
