import 'package:flutter/material.dart';
import 'package:pizza_time/helpers/decoration_functions.dart';
import 'package:pizza_time/helpers/form_validator.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/auth/sign_in_up_bar.dart';
import 'package:pizza_time/widgets/auth/title.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
    required this.onRegisterClicked,
  }) : super(key: key);

  final VoidCallback onRegisterClicked;
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>
    with SingleTickerProviderStateMixin, InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _password;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.2,
      child: Column(
        children: [
          const Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AuthTitle(
                title: 'Welcome\nPizza Time',
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _email,
                      decoration: signInInputDecoration(hintText: 'Email'),
                      validator: (value) {
                        if (!isRequired(value)) {
                          return 'Please enter some text';
                        }
                        if (!isEmailValid(value ?? "")) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _password,
                      obscureText: !_isPasswordVisible,
                      decoration: signInInputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (!isRequired(value)) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SignInBar(
                      onPressed: _onSend,
                      isLoading: _isLoading,
                      label: "Sign In",
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          widget.onRegisterClicked.call();
                        },
                        child: const Text(
                          'Go ahead to register',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Palette.darkBlue,
                          ),
                        ),
                      ),
                    ),
                  ])),
            ),
          ),
        ],
      ),
    );
  }

  void _onSend() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }
  }
}
