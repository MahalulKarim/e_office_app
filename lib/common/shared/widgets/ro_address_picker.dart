import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:eofficeapp/common/models/ro_address_response.dart';
import 'package:eofficeapp/common/shared/services/ro_service.dart';

class RoAddressPickerController extends GetxController {
  final _addresses = <RoAddress>[].obs;
  List<RoAddress> get addresses => _addresses.toList();
  set addresses(value) => _addresses.value = value;

  @override
  void onInit() {
    getRoAddress('');
    super.onInit();
  }

  getRoAddress(String query) async {
    final response = await RoService().getAddress(query);

    addresses = response!.data;
  }
}

class RoAddressPicker extends StatelessWidget {
  const RoAddressPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoAddressPickerController());
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih kota/kecamatan')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              name: 'query',
              onChanged: (val) => EasyDebounce.debounce(
                  'search-address', const Duration(milliseconds: 250), () {
                controller.getRoAddress(val!);
              }),
              decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  hintText: 'Cari alamat',
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.separated(
                separatorBuilder: (c, i) => const Divider(),
                itemBuilder: (c, i) {
                  final address = controller.addresses[i];
                  return ListTile(
                    dense: true,
                    onTap: () => Get.back(result: address),
                    title: Text(address.address),
                  );
                },
                itemCount: controller.addresses.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
