import 'package:flutter/material.dart';
import 'package:flutter_movies_app/model/result_data.dart';
import 'package:flutter_movies_app/utils/constant.dart';

class ListItemWidget extends StatelessWidget {
  final ResultData resultData;
  final Function function;

  const ListItemWidget({
    Key key,
    this.resultData,
    this.function

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: function,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(6.0),
                bottom: Radius.circular(6.0)
            ),
            child: new FadeInImage.assetNetwork(
              placeholder: AssetsImages.imgPlaceholder,
              image: 'https://image.tmdb.org/t/p/w185${resultData.backdropPath}',
              fit: BoxFit.fill,
            ),
          ),
        )
    );
  }
}