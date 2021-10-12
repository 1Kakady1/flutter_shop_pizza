import 'package:flutter/material.dart';
import 'package:pizza_time/widgets/buttons/default/button_default.dart';

class Register extends StatelessWidget {
  const Register({Key? key, required this.onSignInPressed}) : super(key: key);

  final VoidCallback onSignInPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonDefault(
        onPress: onSignInPressed,
        child: Text("Go to login"),
      ),
    );
  }
}
