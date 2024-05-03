import 'package:flutter/material.dart';
import 'package:eofficeapp/common/models/laporan_response.dart';

import 'item_list_laporan_detail.dart';

class ItemListLaporan extends StatelessWidget {
  const ItemListLaporan({
    Key? key,
    required this.item,
  }) : super(key: key);

  final TugasSimple item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: item.dateIsNow == 1 &&
                (item.statusTidakMasuk == null ||
                    (item.statusTidakMasuk ?? 0) == 0)
            ? DecorationImage(
                image: item.isHoliday == 1
                    ? const AssetImage('assets/grad2.png')
                    : (item.statusTidakMasuk != null &&
                            (item.statusTidakMasuk ?? 0) > 0 &&
                            (item.statusTidakMasuk ?? 0) < 4)
                        ? const AssetImage('assets/grad0.png')
                        : const AssetImage('assets/grad1.png'),
                fit: BoxFit.cover,
              )
            : null,
        color: item.dateIsNow == 1
            ? item.isHoliday == 1
                ? Colors.red.shade100
                : (item.statusTidakMasuk != null &&
                        (item.statusTidakMasuk ?? 0) > 0 &&
                        (item.statusTidakMasuk ?? 0) < 4)
                    ? Colors.purple
                    : Colors.white
            : Colors.white,
        border: Border(
          top: BorderSide(
            width: item.dateIsNow == 1 ? 0 : 1,
            color: Colors.grey.shade300,
          ),
          bottom: BorderSide(
            width: item.dateIsNow == 1 ? 0 : 1,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 75,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: item.dateIsNow == 1 ? 25 : 12,
                ),
                decoration: BoxDecoration(
                  color: item.dateIsNow == 1
                      ? Colors.transparent
                      : item.isHoliday == 1
                          ? Colors.red
                          : Colors.grey.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      item.textDay ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: item.isHoliday == 1
                            ? Colors.white
                            : item.dateIsNow == 1
                                ? Colors.white
                                : item.dateIsMore == 1
                                    ? Colors.grey
                                    : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      (item.day ?? ""),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: item.isHoliday == 1
                            ? Colors.white
                            : item.dateIsNow == 1
                                ? Colors.white
                                : item.dateIsMore == 1
                                    ? Colors.grey
                                    : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.textMonth ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: item.isHoliday == 1
                            ? Colors.white
                            : item.dateIsNow == 1
                                ? Colors.white
                                : item.dateIsMore == 1
                                    ? Colors.grey
                                    : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.year.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: item.isHoliday == 1
                            ? Colors.white
                            : item.dateIsNow == 1
                                ? Colors.white
                                : item.dateIsMore == 1
                                    ? Colors.grey
                                    : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              width: 2,
              thickness: 2,
              color: item.isHoliday == 1 ? Colors.red.shade100 : null,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: item.dateIsNow == 1 ? 21 : 10,
                ),
                child: ItemListLaporanDetail(
                  item: item,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
