import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/category_response.dart';

class CategoryService extends HttpHelper {
  CategoryService() : super(baseUrl: '${Config.baseUrl}/categories');

  Future<List<Category>> getAll() async {
    final response = await dio.get('');
    final parsedResponse = categoryFromJson(response.data);
    return parsedResponse;
  }
}
