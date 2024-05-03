import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/ro_subdistricts_response.dart';

import '../../models/ro_address_response.dart';
import '../../models/ro_cities_response.dart';
import '../../models/ro_provinces_response.dart';

class RoService extends HttpHelper {
  RoService() : super(baseUrl: '${Config.baseUrlOffice}/api/ro/');

  Future<RoAddressResponse?> getAddress(String query) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'query': query,
    });
    final response = await dio.post('/get_address',
        data: formData,
        options: Options(
          responseType: ResponseType.plain,
        ));
    if (response.statusCode != 200) {
      return null;
    }

    final parsedResponse = roAddressResponseFromJson(response.data);
    return parsedResponse;
  }

  Future<RoProvincesResponse?> getProvinces() async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
    });
    final response = await dio.post(
      '/get_provinces',
      data: formData,
    );
    if (response.statusCode != 200) {
      return null;
    }
    final parsedResponse =
        roProvincesResponseFromJson(jsonEncode(response.data));
    return parsedResponse;
  }

  Future<RoCitiesResponse?> getCities({required String provinceId}) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'province_id': provinceId,
    });
    final response = await dio.post(
      '/get_cities',
      data: formData,
    );
    if (response.statusCode != 200) {
      return null;
    }
    final parsedResponse = roCitiesResponseFromJson(jsonEncode(response.data));
    return parsedResponse;
  }

  Future<RoSubdistrictsResponse?> getSubdistricts(
      {required String cityId}) async {
    FormData formData = FormData.fromMap({
      'X-API-KEY': '3hKnM&pQ#JCs_M',
      'city_id': cityId,
    });
    final response = await dio.post(
      '/get_subdistricts',
      data: formData,
    );
    if (response.statusCode != 200) {
      return null;
    }
    final parsedResponse =
        roSubdistrictsResponseFromJson(jsonEncode(response.data));
    return parsedResponse;
  }
}
