import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eofficeapp/common/themes/styles.dart';

class EmptyProduct extends StatelessWidget {
  const EmptyProduct({
    Key? key,
    this.icon = CupertinoIcons.gift_alt_fill,
    this.txt = 'Belum ada produk',
  }) : super(key: key);

  final IconData icon;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 100,
            color: mainColor,
          ),
          Text(
            txt,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
