import 'package:flutter/material.dart';
import 'package:eofficeapp/common/themes/styles.dart';

class ItemTabVideo extends StatelessWidget {
  const ItemTabVideo({
    Key? key,
    required this.name,
    this.active = false,
    this.onTap,
  }) : super(key: key);

  final String name;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: active ? mainColor : Colors.grey.shade300,
        ),
        child: Column(
          children: [
            Text(
              name,
              maxLines: 1,
              style: TextStyle(
                color: active ? Colors.white : Colors.grey.shade500,
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
