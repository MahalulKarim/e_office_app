import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/shared/services/cek_kantor_service.dart';
import 'package:get/get.dart';

class CekKantorController extends GetxController {
  Future<String?> cekIdKantor(String idKantor) async {
    final response = await CekKantorService().cekIdKantor(idKantor);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var kantorData = response.data['data'];
      if (kantorData['nama_kantor'] != null) {
        Config.setIdKantor(idKantor);
        Config.setNamaKantor(kantorData['nama_kantor']);
        return kantorData['nama_kantor'];
      } else {
        return null;
      }
    }
    return null;
  }

  Future<String?> cekKodeKantor(String kodeKantor) async {
    final response = await CekKantorService().cekKodeKantor(kodeKantor);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var kantorData = response.data['data'];
      if (kantorData['nama_kantor'] != null) {
        Config.setIdKantor(kantorData['id']);
        Config.setNamaKantor(kantorData['nama_kantor']);
        return kantorData['nama_kantor'];
      } else {
        return null;
      }
    }
    return null;
  }
}
