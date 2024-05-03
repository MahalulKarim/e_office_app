import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/store_detail_response.dart';

class StoreService extends HttpHelper {
  StoreService() : super(baseUrl: '${Config.baseUrlv3}/toko/');

  Future<Response> update(String id, dynamic params, XFile? photo) async {
    return await dio.post(
      '/update/$id',
      data: FormData.fromMap({
        ...params,
        'new_image': photo != null
            ? await MultipartFile.fromFile(
                photo.path,
                filename: photo.name,
              )
            : null,
      }),
    );
  }

  Future<dynamic> getAll(int page, int limit, query) async {
    final response = await dio.post(
      '/get_all',
      data: FormData.fromMap({
        'page': page,
        'limit': limit,
        'query': query,
      }),
    );
    if (response.statusCode == HttpStatus.ok) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<StoreDetail> getDetail(String storeId) async {
    final response = await dio.post(
      '/detail',
      data: FormData.fromMap({
        'id_toko': storeId,
      }),
    );
    final parsedResponse = storeDetailFromJson(response.data);
    return parsedResponse;
  }
}
