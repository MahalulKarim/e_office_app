import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/article_categories.dart';

class ArticleCategoriesService extends HttpHelper {
  ArticleCategoriesService() : super(baseUrl: Config.baseUrlArtikel);

  Future<List<ArticleCategories>> getArticleCategories() async {
    final response = await dio.get(
      '$baseUrl/categories',
    );
    final parsedResponse = articleCategoriesFromJson(response.data);

    return parsedResponse;
  }
}
