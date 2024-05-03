import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/themes/styles.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          statusBarColor: mainColor.shade900,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
        ),
        title: const Text('Informasi'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon.png'),
            const SizedBox(height: 10),
            const Text(
              'DC adalah Market Place E-Katalog kadin Wonosobo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Kontak'),
            InkWell(
              child: const Text('085729670954',
                  style: TextStyle(color: Colors.blue)),
              onTap: () => launchUrl(Uri.parse('https://wa.me/6285729670954')),
            ),
            const SizedBox(height: 16),
            const Text('Versi App : 1')
          ],
        ),
      ),
    );
  }
}
