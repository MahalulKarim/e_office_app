import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../models/store_detail_response.dart';

class StoreItem extends StatelessWidget {
  const StoreItem({Key? key, required this.store}) : super(key: key);

  final StoreDetail store;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed('/store/detail', arguments: {
        "id_store": store.id,
      }),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            CachedNetworkImage(
              height: 130,
              // width: 130,
              fit: BoxFit.cover,
              imageUrl: Config.baseUrlToko + store.logo,
              placeholder: (context, url) => SkeletonAnimation(
                shimmerColor: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(4),
                shimmerDuration: 1000,
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const SizedBox(
                height: 130,
                // width: 130,
                child: Icon(
                  Icons.store_mall_directory,
                  size: 32,
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  Text(
                    store.namaToko,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    store.telp,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
