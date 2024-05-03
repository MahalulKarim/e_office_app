import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../models/store_detail_response.dart';

class StoreItemNew extends StatelessWidget {
  const StoreItemNew({Key? key, required this.store}) : super(key: key);

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
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 0.8, color: Colors.grey.shade200),
        ),
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            CachedNetworkImage(
              height: 130,
              // width: 130,
              // fit: BoxFit.cover,
              imageUrl: Config.baseUrlToko + store.logo,
              imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                child: Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    store.telp,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
