import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_mode/kiosk_mode.dart';
import 'package:lockwebpage/my_webview.dart';
import 'package:flutter/services.dart';

// import 'package:hardware_buttons/hardware_buttons.dart' as HardwareButtons;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Stream<KioskMode> _currentMode = watchKioskMode();

  void popDialog() {
    TextEditingController _controller = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {Navigator.pop(context);},
                  icon: Icon(Icons.close),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _controller,
                maxLength: 4,
                onSubmitted: (s) {
                  if (s == '1234') {
                    exit(0);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    startKioskMode();
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.runtimeType.toString() == 'RawKeyDownEvent') {
            if (event.logicalKey.keyLabel == "Go Back") {
              print('Allow exiting app');
              popDialog();
            }
          }
        },
        child: MyWebView(
          selectedUrl: 'https://www.wisniowski.pl/',
        ),
      ),
    );
  }
}
