import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/background_painter/background_painter.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  bool isActive = false;
  late Timer _timer;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 200));
    _controller.forward();
    _timer = new Timer.periodic(const Duration(seconds: 300), (Timer timer) {
      setState(() {
        if (isActive == true) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        isActive = !isActive;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                height: mediaHeight / 2,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                    color: AppColors.write.withOpacity(0.5),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(40))),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ])),
              ),
            )
          ],
        );
      }),
    );
  }
}
