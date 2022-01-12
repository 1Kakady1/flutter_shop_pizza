import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/helpers/form_validator.dart';
import 'package:pizza_time/model/user.dart';
import 'package:pizza_time/widgets/profile/profile_inputs/profile_input.dart';
import 'package:pizza_time/widgets/snack/snack.dart';
import 'package:pizza_time/widgets/upload_img_in_firebase/upload_img_in_firebase.dart';
import 'package:pizza_time/widgets/user/avatar/avatar.dart';

class ProfileUser extends StatefulWidget {
  final bool isAuth;
  final UserCustom user;
  final void Function(UserCustom user) onChangeUserInfo;

  ProfileUser(
      {required this.isAuth,
      required this.user,
      required this.onChangeUserInfo});

  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> with InputValidationMixin {
  final _api = new Api();
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    var maskFormatter = new MaskTextInputFormatter(
        mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          UserAvatar(
            user: widget.user,
            isAuth: true,
            size: 80,
            isBorder: true,
            hideName: true,
          ),
          UploadImgInFirebase(onUplodinSuccess: (String url) async {
            _api.updateUserField(widget.user.id, "preview", url).then((value) {
              widget.onChangeUserInfo(widget.user.copyWith(preview: url));
            });
          }),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  child: Text(FlutterI18n.translate(context, "profile.title")),
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  width: double.infinity,
                  child: ProfileInput(
                    isLoading: _isLoading,
                    labelText: FlutterI18n.translate(context, "label.name"),
                    initValue: widget.user.name,
                    onSave: (val, callback) {
                      onUpdate("name", val, callback);
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ProfileInput(
                    isLoading: _isLoading,
                    labelText: FlutterI18n.translate(context, "label.phone"),
                    initValue: widget.user.phone,
                    maskFormatter: maskFormatter,
                    validator: (String? phone) {
                      if (!isEqualsNumber(phone?.length ?? 0, 18)) {
                        return FlutterI18n.translate(context, "errors.phone");
                      }

                      return null;
                    },
                    onSave: (val, callback) {
                      onUpdate("phone", val, callback);
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ProfileInput(
                    isLoading: _isLoading,
                    labelText: FlutterI18n.translate(context, "label.email"),
                    initValue: widget.user.email,
                    validator: (String? value) {
                      if (!isEmailValid(value ?? "")) {
                        return FlutterI18n.translate(context, "errors.email");
                      }

                      return null;
                    },
                    onSave: (val, callback) {
                      onUpdate("email", val, callback);
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ProfileInput(
                    searchCity: true,
                    isLoading: _isLoading,
                    labelText: FlutterI18n.translate(context, "label.address"),
                    initValue: widget.user.address,
                    onSave: (val, callback) {
                      onUpdate("address", val, callback);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onUpdate(String field, val, void Function() callback) {
    setState(() {
      _isLoading = true;
    });
    _api.updateUserField(widget.user.id, field, val).then((value) {
      final json = widget.user.toJson();
      json[field] = val;
      final rez = new UserCustom.fromJson(json);
      widget.onChangeUserInfo(rez);
      callback();
      setState(() {
        _isLoading = false;
      });
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar(e.toString()));
      callback();
      setState(() {
        _isLoading = false;
      });
    });
  }
}
