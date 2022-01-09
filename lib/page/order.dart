import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/helpers/form_validator.dart';
import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/model/order.model.dart';
import 'package:pizza_time/redux/state/cart/cart.selector.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/background_painter/background_painter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pizza_time/widgets/city_search/city_search.dart';
import 'package:pizza_time/widgets/input_date/input_date.dart';
import 'package:redux/redux.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin, InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  bool isActive = false;
  final _formKey = GlobalKey<FormState>();
  late String _address;
  late TextEditingController _email;
  late TextEditingController _phone;
  late TextEditingController _date;
  late TextEditingController _fullName;
  late TextEditingController _comments;
  bool isSending = false;
  @override
  void initState() {
    final Store<AppState> store =
        StoreProvider.of<AppState>(context, listen: false);
    final userInfo = store.state.user.info;
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 200));
    _controller.forward();
    _address = userInfo.address;
    _email = TextEditingController(text: userInfo.email);
    _phone = TextEditingController(text: userInfo.phone);
    _date = TextEditingController(text: "");
    _fullName = TextEditingController(text: userInfo.name);
    _comments = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _email.dispose();
    _phone.dispose();
    _date.dispose();
    _fullName.dispose();
    _comments.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var maskFormatter = new MaskTextInputFormatter(
        mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final mediaWidth = constraints.maxWidth;
        final mediaHeight = constraints.maxHeight;

        return Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(
                  animation: _controller,
                ),
              ),
            ),
            Center(
              child: Container(
                width: mediaWidth,
                height: mediaHeight - 200,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                    color: AppColors.write.withOpacity(0.5),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(40))),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _fullName,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: AppColors.black,
                                ),
                                hintText: 'What do people call you?',
                                labelText: 'Name *',
                              ),
                              validator: (value) {
                                if (!isRequired(value)) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _email,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.email,
                                  color: AppColors.black,
                                ),
                                hintText: 'example@exp.com',
                                labelText: 'Email *',
                              ),
                              validator: (value) {
                                if (!isEmailValid(value ?? "")) {
                                  return 'Invalid email';
                                }
                                if (!isRequired(value)) {
                                  return 'Please enter some text';
                                }

                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _phone,
                              inputFormatters: [maskFormatter],
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.call,
                                  color: AppColors.black,
                                ),
                                hintText: '',
                                labelText: 'Phone *',
                              ),
                              validator: (value) {
                                if (!isRequired(value)) {
                                  return 'Please enter some text';
                                }
                                if (!isEqualsNumber(value?.length ?? 0, 18)) {
                                  return 'Phone error';
                                }
                                print("lenghr phone ${value?.length}");
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputDate(
                              label: "Date *",
                              controller: _date,
                              onConfirm: (String value) {
                                _date.text = value;
                              },
                              validator: (String? value) {
                                if (value == null || value == "") {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CitySearch(
                              snackbar: _snackBar,
                              label: "Address*",
                              value: _address,
                              isIcon: true,
                              onSetValue: (MapBoxPlace value) {
                                setState(() {
                                  _address = value.placeName ?? "";
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: TextFormField(
                                controller: _comments,
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.comment,
                                    color: AppColors.black,
                                  ),
                                  labelText: 'You comments',
                                ),
                                validator: (value) {
                                  final len = value?.length ?? 0;
                                  if (len > 30) {
                                    return 'Message max len 30';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Center(
                              child: Container(
                                child: Stack(children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: AppColors.red[200],
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 16)),
                                    onPressed: _onSend,
                                    child: Text('Отправить'),
                                  ),
                                  Positioned(
                                      right: 10,
                                      top: 20,
                                      child: SizedBox(
                                          width: 12,
                                          height: 12,
                                          child: isSending
                                              ? CircularProgressIndicator(
                                                  strokeWidth: 2.0,
                                                  color: AppColors.write)
                                              : null))
                                ]),
                              ),
                            ),
                          ])),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  void _onSend() {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final List<CartItem> cart = CartSelectors.products(store.state);
    if (_formKey.currentState!.validate()) {
      final order = Api();
      order
          .createOrder(OrderModel(
              name: _fullName.text,
              email: _email.text,
              date: _date.text,
              address: _address,
              products: cart))
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBar("Create order. The manager will contact you."),
        );
        _formKey.currentState?.reset(); // работате только с полем комм.
        _comments.text = "";
        _email.text = "";
        _phone.text = "";
        _fullName.text = "";
        _date.text = "";
        setState(() {
          _address = "";
        });
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBar("Error: ${e.toString()}"),
        );
      });
    }
  }
}

//TODO: вынести в отдельный виджет
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
