import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlaceHolderImage extends StatelessWidget {
  final String imgUrl;
  const PlaceHolderImage({Key key, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      color: Colors.black.withOpacity(0.5),
      imageUrl: imgUrl,
      // placeholder: (context, url) => Text('loading...'),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
      colorBlendMode: BlendMode.colorBurn,
      filterQuality: FilterQuality.high,
    );
  }
}
