import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:eofficeapp/common/configs/config.dart';
import 'package:eofficeapp/common/helpers/http.dart';
import 'package:eofficeapp/common/models/tv_live_response.dart';
import 'package:eofficeapp/common/models/youtube_api_response.dart';
import 'package:eofficeapp/common/models/youtube_localapi_search.dart';

class YoutubeApiService extends HttpHelper {
  YoutubeApiService() : super(baseUrl: '${Config.baseUrlv3}videos/');

  Future<YoutubeApiResponse> getVideosFromApi(int page) async {
    super.baseUrl = 'https://youtube.diengcyber.com';
    final response = await dio.get(
      '/videos',
      queryParameters: {
        "page": page,
      },
      options: Options(
        responseType: ResponseType.plain,
      ),
    );

    return youtubeApiResponseFromJson(response.data);
  }

  Future<YoutubeLocalApiSearch?> getChannelVideos(
      String channelName, String? pageToken) async {
    final response = await dio.get('get_channel_video', queryParameters: {
      'channel': channelName,
      'pageToken': pageToken,
    });
    if (response.statusCode == HttpStatus.ok) {
      return youtubeLocalApiSearchFromJson(jsonEncode(response.data));
    }
    return null;
  }

  Future<YoutubeLocalApiSearch?> getSearchVideos(
      String q, String? pageToken) async {
    final response = await dio.get('get_search', queryParameters: {
      'search': q,
      'pageToken': pageToken,
    });
    if (response.statusCode == HttpStatus.ok) {
      return youtubeLocalApiSearchFromJson(jsonEncode(response.data));
    }
    return null;
  }

  Future<List<TvLiveResponse>?> getLiveTv() async {
    final response = await dio.get('get_live_tv');
    if (response.statusCode == HttpStatus.ok) {
      return tvLiveResponseFromJson(jsonEncode(response.data));
    }
    return null;
  }
}
