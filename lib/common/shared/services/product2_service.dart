import 'package:dio/dio.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';

class Product2Service extends HttpHelper {
  Product2Service() : super(baseUrl: '${Config.baseUrlv3}/products');

  Future<Response> getSearchPT({
    int page = 1,
    int limit = 20,
    String query = '',
  }) async {
    final response = await dio.post(
      '/get_search_product_toko_all',
      data: FormData.fromMap(
        {
          'page': page,
          'limit': limit,
          'query': query,
        },
      ),
    );
    return response;
  }

  Future<Response> getAll({
    int page = 1,
    int limit = 6,
    String categoryId = '',
    String query = '',
  }) async {
    final response = await dio.post(
      '/get_all',
      data: FormData.fromMap(
        {
          'page': page,
          'limit': limit,
          'id_kategori': categoryId,
          'query': query,
        },
      ),
    );
    return response;
  }

  Future<Response> getByIdToko({
    int idToko = 0,
    int page = 1,
    int limit = 6,
    String categoryId = '',
    String query = '',
  }) async {
    final response = await dio.post(
      '/get_all',
      data: FormData.fromMap(
        {
          'page': page,
          'limit': limit,
          'id_toko': idToko,
          'id_kategori': categoryId,
          'query': query,
          'requestFrom': 'toko',
        },
      ),
    );
    return response;
  }
}
