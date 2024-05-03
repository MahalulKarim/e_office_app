import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/product_detail_response.dart';
import 'package:eofficeapp/common/models/product_response.dart';

class ProductService extends HttpHelper {
  ProductService() : super(baseUrl: '${Config.baseUrl}/products');

  Future<Response> logTr(
      String idProduk, String storeId, String? userClickId) async {
    final response = await dio.post(
      '/log_chat_wa',
      data: FormData.fromMap(
        {
          'id_produk': idProduk,
          'id_toko': storeId,
          'id_user_click': userClickId,
        },
      ),
    );
    return response;
  }

  Future<Response> delete(String idProduk, String storeId) async {
    final response = await dio.post(
      '/delete',
      data: FormData.fromMap(
        {
          'id_produk': idProduk,
          'id_toko': storeId,
        },
      ),
    );
    return response;
  }

  Future<Map<String, dynamic>?> getById(int idProduk, String storeId) async {
    final response = await dio.post(
      '/get_by_id',
      data: FormData.fromMap(
        {
          'id_produk': idProduk,
          'id_toko': storeId,
          'level': 0,
        },
      ),
    );
    if (response.statusCode == HttpStatus.ok) {
      return {
        'produk': Product.fromJson(response.data['produk']),
        'gambar': response.data['gambar']
      };
    } else {
      return null;
    }
  }

  Future<Response> update(
      String idProduk, dynamic params, List<dynamic> storeImage) async {
    Map<String, MultipartFile> imageParams = {};

    for (var item in storeImage) {
      if (item.runtimeType == XFile) {
        imageParams['image_${storeImage.indexOf(item)}'] =
            await MultipartFile.fromFile(
          item.path,
          filename: item.name,
        );
      }
    }

    final response = await dio.post(
      '/update/$idProduk',
      data: FormData.fromMap({
        ...params,
        ...imageParams,
      }),
    );

    return response;
  }

  Future<Response> create(dynamic params, List<XFile> storeImage) async {
    Map<String, MultipartFile> imageParams = {};

    for (var item in storeImage) {
      imageParams['image_${storeImage.indexOf(item)}'] =
          await MultipartFile.fromFile(
        item.path,
        filename: item.name,
      );
    }

    final response = await dio.post(
      '/create',
      data: FormData.fromMap({
        ...params,
        ...imageParams,
      }),
    );

    return response;
  }

  Future<List<Product>> getAll(
      {String categoryId = '', String query = '', String tag = ''}) async {
    final response = await dio.post(
      '/get_all_new',
      data: FormData.fromMap(
        {
          'id_kategori': categoryId,
          'query': query,
          'level': 0,
          'tag': tag,
        },
      ),
    );
    final parsedResponse = productFromJson(response.data);
    return parsedResponse;
  }

  Future<List<Product>> getByCategory(String categoryId) async {
    final response = await dio.post(
      '/get_by_category',
      data: FormData.fromMap(
        {
          'id_kategori': categoryId,
          'level': 0,
        },
      ),
    );
    final parsedResponse = productFromJson(response.data);

    return parsedResponse;
  }

  Future<List<Product>> getByStoreId(String storeId) async {
    final response = await dio.post(
      '/get_by_id_toko2',
      data: FormData.fromMap(
        {
          'id_toko': storeId,
        },
      ),
    );
    final parsedResponse = productFromJson(response.data);

    return parsedResponse;
  }

  Future<ProductDetail> getProductDetail(String productId) async {
    final response = await dio.post('/detail',
        data: FormData.fromMap({'id_produk': productId}));
    return productDetailFromJson(response.data);
  }
}
