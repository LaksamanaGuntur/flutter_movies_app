import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_movies_app/bloc/user_bloc.dart';
import 'package:flutter_movies_app/model/api_response.dart';
import 'package:flutter_movies_app/model/result_data.dart';

import 'list_item_widget.dart';

class ListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListWidgetState();
  }
}

class _ListWidgetState extends State<ListWidget> {
  @override
  void initState() {
    super.initState();
    bloc.getUser();
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
            style: Theme.of(context).textTheme.subtitle),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error", style: Theme.of(context).textTheme.subtitle),
      ],
    ));
  }

//  Widget _buildUserWidget(List<ResultData> data) {
//    return Container(
//      margin: EdgeInsets.only(top: 5),
//      child: MediaQuery.removePadding(
//          context: context,
//          removeTop: true,
//          child: ListView.builder(
//            physics: BouncingScrollPhysics(),
//            scrollDirection: Axis.vertical,
//            itemCount: data.length,
//            itemBuilder: (BuildContext context, int index) {
//              return ListItemWidget(
//                resultData: data[index],
//              );
//            },
//          )
//      ),
//    );
//  }

  Widget _buildUserWidget(List<ResultData> data) {
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: ListItemWidget(
                resultData: data[index],
              ),
//              onTap: () => openDetailPage(snapshot.data, index),
            ),
          );
        });
  }
}
