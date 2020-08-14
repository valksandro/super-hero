import 'dart:convert';

import 'package:http/http.dart';
import 'package:super_hero/core/repositories/remote/interface_repository.dart';
import 'package:super_hero/core/utilities/app_info.dart';

import 'http/http_api.dart';

class HeroRepository implements IRepository {
  @override
  Future listAll() async {
    final Response response = await HttpApi.of().httpOperation(Http.get, '${getUrl()}/search/_');
    if(response?.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('Was not possible load the heroes :(');
  }
}
