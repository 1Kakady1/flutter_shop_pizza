import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/helpers/decoration_functions.dart';
import 'package:pizza_time/helpers/form_validator.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/auth/sign_in_up_bar.dart';
import 'package:pizza_time/widgets/auth/title.dart';
import 'package:pizza_time/widgets/city_search/city_search.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.onSignInPressed}) : super(key: key);

  final VoidCallback onSignInPressed;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin, InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _confirme_password;
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isPasswordConfirmeVisible = false;
  late String _address;
  late TextEditingController _phone;
  late TextEditingController _fullName;

  @override
  void initState() {
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    _address = "";
    _confirme_password = TextEditingController(text: "");
    _fullName = TextEditingController(text: "");
    _phone = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    _confirme_password.dispose();
    _fullName.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var maskFormatter = new MaskTextInputFormatter(
        mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
    return Container(
      width: size.width / 1.2,
      child: Column(
        children: [
          const Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AuthTitle(
                title: 'Create\nAccount',
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _email,
                      decoration: registerInputDecoration(labelText: 'Email'),
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
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _fullName,
                      decoration:
                          registerInputDecoration(labelText: 'Your full name'),
                      validator: (value) {
                        if (!isRequired(value)) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      controller: _phone,
                      inputFormatters: [maskFormatter],
                      decoration: registerInputDecoration(labelText: 'Phone'),
                      validator: (value) {
                        if (!isRequired(value)) {
                          return 'Please enter some text';
                        }
                        if (!isEqualsNumber(value?.length ?? 0, 18)) {
                          return 'Phone error';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _password,
                      obscureText: !_isPasswordVisible,
                      decoration: registerInputDecoration(
                        labelText: 'Password',
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
                        if (!isStringLen(value ?? "", 5)) {
                          return 'The password is too short';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _confirme_password,
                      obscureText: !_isPasswordConfirmeVisible,
                      decoration: registerInputDecoration(
                        labelText: 'Confirme password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordConfirmeVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordConfirmeVisible =
                                  !_isPasswordConfirmeVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        final String val = value ?? "";
                        if (!isRequired(value)) {
                          return 'Please enter some text';
                        }
                        if (!isStringLen(val, 5)) {
                          return 'The password is too short';
                        }
                        if (val != _password.text) {
                          return 'Passwords dont match';
                        }
                        return null;
                      },
                    ),
                    CitySearch(
                      snackbar: _snackBar,
                      label: "Address",
                      value: _address,
                      color: AppColors.write,
                      iconColor: Palette.darkBlue,
                      onSetValue: (MapBoxPlace value) {
                        setState(() {
                          _address = value.placeName ?? "";
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SignInBar(
                      onPressed: _onSend,
                      isLoading: _isLoading,
                      label: "Sign Up",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          widget.onSignInPressed.call();
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Palette.darkBlue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ])),
            ),
          ),
        ],
      ),
    );
  }

  void resetForm() {
    setState(() {
      _address = "";
      _isLoading = false;
    });
    _password.text = "";
    _email.text = "";
    _fullName.text = "";
    _confirme_password.text = "";
    _phone.text = "";
  }

  void _onSend() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final api = Api();
      api
          .createUserWithEmailAndPassword(
              password: _password.text,
              email: _email.text,
              name: _fullName.text,
              address: _address,
              phone: _phone.text)
          .then((value) {
        if (value.error != "") {
          ScaffoldMessenger.of(context)
              .showSnackBar(_snackBar("Error: ${value.error}"));
        } else {
          this.resetForm();
          ScaffoldMessenger.of(context).showSnackBar(_snackBar(
              "You have successfully registered. Go to the login form to log in."));
        }
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(_snackBar("Error to create user: ${e.toString()}"));

        setState(() {
          _isLoading = false;
        });
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
