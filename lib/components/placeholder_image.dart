import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlaceHolderImage extends StatelessWidget {
  final String imgUrl;
  const PlaceHolderImage({Key key, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      color: Colors.black.withOpacity(0.4),
      imageUrl: imgUrl,
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
      filterQuality: FilterQuality.low,
      colorBlendMode: BlendMode.multiply,
    );
  }
}
