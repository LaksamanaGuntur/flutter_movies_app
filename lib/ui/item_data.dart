import 'package:flutter/material.dart';
import '../model/result_data.dart';
import '../utils/constant.dart';

class ItemData extends StatelessWidget {
  final ResultData resultData;
  final Function function;

  const ItemData({
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
              image: '${BaseUrl.imageUrl}${resultData.backdropPath}',
              fit: BoxFit.fill,
            ),
          ),
        )
    );
  }
}