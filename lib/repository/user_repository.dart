
import 'package:flutter_movies_app/model/api_response.dart';

import 'user_api_provider.dart';

class UserRepository{
  UserApiProvider _apiProvider = UserApiProvider();

  Future<ApiResponse> getData(){
    return _apiProvider.getData();
  }
}