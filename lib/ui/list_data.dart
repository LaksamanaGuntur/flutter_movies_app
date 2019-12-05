import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../bloc/user_bloc.dart';
import '../repository/api_response.dart';
import '../model/result_data.dart';

import 'item_data.dart';

class ListData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListDataState();
  }
}

class _ListDataState extends State<ListData> {
  @override
  void initState() {
    super.initState();
    bloc.getUser();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<ApiResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.page == 0 && snapshot.data.totalResults == 0) {
            return _buildErrorWidget("Error load data");
          }
          return _buildUserWidget(snapshot.data.results);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Loading data from API...",
              style: Theme.of(context).textTheme.subtitle
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error", style: Theme.of(context).textTheme.subtitle),
        ],
      ),
    );
  }

  Widget _buildUserWidget(List<ResultData> data) {
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: ItemData(
              resultData: data[index],
              function: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(data[index].originalTitle),
                ));
              },
            ),
          );
        });
  }
}
