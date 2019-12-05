import '../repository/api_response.dart';
import '../network/data_api_provider.dart';

class DataRepository{
  DataApiProvider _dataApiProvider = DataApiProvider();

  Future<ApiResponse> getData(){
    return _dataApiProvider.getData();
  }
}