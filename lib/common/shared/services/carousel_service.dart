import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/carousel_response.dart';

class CarouselService extends HttpHelper {
  CarouselService() : super(baseUrl: '${Config.baseUrl}/sliders');

  Future<List<Carousel>> getAll() async {
    final response = await dio.get('');
    final parsedResponse = carouselFromJson(response.data);

    return parsedResponse;
  }
}
