import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pizza_time/helpers/form_validator.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/city_search/city_search.dart';
import 'package:pizza_time/widgets/snack/snack.dart';

class ProfileInput extends StatefulWidget {
  final String? Function(String?)? validator;
  final String initValue;
  final String? hintText;
  final String? labelText;
  final Widget? icon;
  final bool isLoading;
  final MaskTextInputFormatter? maskFormatter;
  final bool? searchCity;
  final void Function(dynamic value, void Function() callback) onSave;
  const ProfileInput(
      {Key? key,
      this.validator,
      required this.initValue,
      this.hintText,
      this.labelText,
      this.icon,
      this.searchCity,
      required this.isLoading,
      required this.onSave,
      this.maskFormatter})
      : super(
          key: key,
        );

  @override
  _ProfileInputState createState() => _ProfileInputState();
}

class _ProfileInputState extends State<ProfileInput>
    with SingleTickerProviderStateMixin, InputValidationMixin {
  late TextEditingController _field;
  final _formKey = GlobalKey<FormState>();
  late bool isDisable;
  @override
  void initState() {
    _field = TextEditingController(text: widget.initValue);
    isDisable = false;
    super.initState();
  }

  @override
  void dispose() {
    _field.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: widget.searchCity == true
                ? CitySearch(
                    snackbar: snackBar,
                    label: widget.labelText,
                    value: _field.text,
                    onSetValue: (MapBoxPlace value) {
                      _field.text = value.placeName ?? "";
                    },
                  )
                : Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _field,
                      inputFormatters: widget.maskFormatter != null
                          ? [widget.maskFormatter as TextInputFormatter]
                          : null,
                      decoration: InputDecoration(
                        icon: widget.icon,
                        hintText: widget.hintText,
                        labelText: widget.labelText,
                      ),
                      validator: (value) {
                        if (!isRequired(value)) {
                          return FlutterI18n.translate(context, "errors.req");
                        }

                        final valid = widget.validator != null
                            ? widget.validator!(value)
                            : null;

                        return valid;
                      },
                    ),
                  ),
          ),
          SizedBox(
            width: 20,
          ),
          widget.isLoading == true && isDisable == true
              ? new CircularProgressIndicator(
                  color: AppColors.red[200],
                )
              : IconButton(
                  icon: const Icon(Icons.save),
                  tooltip: FlutterI18n.translate(context, "tooltip.update"),
                  onPressed: () {
                    bool validate = widget.searchCity == true
                        ? true
                        : _formKey.currentState!.validate();
                    if (validate && widget.isLoading == false) {
                      setState(() {
                        isDisable = true;
                      });
                      widget.onSave(_field.text, () {
                        setState(() {
                          isDisable = false;
                        });
                      });
                    }
                  },
                ),
        ],
      ),
    );
  }
}
