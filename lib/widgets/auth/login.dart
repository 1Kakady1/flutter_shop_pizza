import 'package:flutter/material.dart';
import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/helpers/decoration_functions.dart';
import 'package:pizza_time/helpers/form_validator.dart';
import 'package:pizza_time/routes/routes.dart';
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
      final _api = Api();
      setState(() {
        _isLoading = true;
      });
      _api
          .signInWithEmailAndPassword(_email.text, _password.text)
          .then((value) {
        if (value.error == "" && value.data != false) {
          Navigator.popAndPushNamed(context, PathRoute.home);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(_snackBar("Error: ${value.error.toString()}"));
        }
        setState(() {
          _isLoading = false;
        });
      }).catchError((e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(_snackBar("Error: ${e.toString()}"));
      });
    }
  }
}

SnackBar _snackBar(String msg) {
  return SnackBar(
    content: Text(msg),
    duration: const Duration(milliseconds: 2000),
    width: 310.0, // Width of the SnackBar.
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}
