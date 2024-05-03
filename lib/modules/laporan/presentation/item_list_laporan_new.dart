import 'package:flutter/material.dart';
import 'package:eofficeapp/common/models/laporan_response.dart';
import 'package:eofficeapp/common/themes/styles.dart';

import 'item_list_laporan_detail.dart';

class ItemListLaporanNew extends StatelessWidget {
  const ItemListLaporanNew({
    Key? key,
    required this.item,
  }) : super(key: key);

  final TugasSimple item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 0,
        right: 6,
      ),
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 75,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item.isHoliday == 1
                        ? Colors.red
                        : (item.dateIsLess == 1 && item.status == 0)
                            ? Colors.grey
                            : (item.statusTidakMasuk != null &&
                                    (item.statusTidakMasuk ?? 0) > 0 &&
                                    (item.statusTidakMasuk ?? 0) < 4)
                                ? Colors.amber.shade600
                                : item.dateIsMore == 1
                                    ? Colors.grey
                                    : mainColor,
                    image: item.dateIsNow == 1 &&
                            (item.statusTidakMasuk == null ||
                                (item.statusTidakMasuk ?? 0) == 0)
                        ? DecorationImage(
                            image: item.isHoliday == 1
                                ? const AssetImage('assets/grad2.png')
                                : const AssetImage('assets/grad1.png'),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.day ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        item.textDay ?? "",
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  item.textMonth ?? "",
                  style: const TextStyle(fontSize: 10),
                ),
                Text(
                  item.year ?? "",
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          Expanded(
            child: item.dateIsMore == 1
                ? const SizedBox()
                : Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: item.isHoliday == 1
                          ? Colors.red.shade200
                          : (item.dateIsLess == 1 && item.status == 0)
                              ? Colors.grey
                              : (item.statusTidakMasuk != null &&
                                      (item.statusTidakMasuk ?? 0) > 0 &&
                                      (item.statusTidakMasuk ?? 0) < 4)
                                  ? Colors.amber.shade100
                                  : mainColor.shade200,
                      image: item.dateIsNow == 1 &&
                              (item.statusTidakMasuk == null ||
                                  (item.statusTidakMasuk ?? 0) == 0)
                          ? DecorationImage(
                              image: item.isHoliday == 1
                                  ? const AssetImage('assets/grad2.png')
                                  : const AssetImage('assets/grad1.png'),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: ItemListLaporanDetail(
                      item: item,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
