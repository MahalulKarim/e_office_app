// ignore: file_names
import 'package:flutter/material.dart';

class LogoBanner extends StatelessWidget {
  const LogoBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Image.asset(
            'assets/logo.webp',
            height: 70,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Supported by"),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/s4i.png',
                  height: 70,
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/kemenperin.png',
                  height: 70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
