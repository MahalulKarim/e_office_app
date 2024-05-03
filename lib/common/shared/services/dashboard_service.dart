import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/product_response.dart';

class DashboardService extends HttpHelper {
  DashboardService() : super(baseUrl: '${Config.baseUrlv3}/dashboard');

  Future<List<Product>> getProdukUnggulan() async {
    final response = await dio.get('/product_unggulan');
    if (response.statusCode == HttpStatus.ok) {
      return productFromJson(response.data);
    } else {
      return [];
    }
  }

  Future<dynamic> getProdukTerbaru(int page, int limit) async {
    final response = await dio.post(
      '/product_terbaru',
      data: FormData.fromMap(
        {
          'page': page,
          'limit': limit,
        },
      ),
    );
    // print("AAAAAAAAAAAAAAAAAA");
    // print(response.data);
    if (response.statusCode == HttpStatus.ok) {
      return response.data;
    } else {
      return null;
    }
  }
}
