import 'package:flutter_movies_app/repository/api_response.dart';
import 'package:flutter_movies_app/repository/data_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _repository = DataRepository();
  final _subject = BehaviorSubject<ApiResponse>();

  getUser() async {
    ApiResponse response = await _repository.getData();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ApiResponse> get subject => _subject;

}
final bloc = UserBloc();