import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/model/daily.dart';
import 'package:flutter/material.dart';

class HeroDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Daliy daliy = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: 'hero${daliy.title}',
                child: Container(
                  height: 400,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          color: Colors.black.withOpacity(0.5),
                          imageUrl: daliy.imageUrl,
                          placeholder: (context, url) => Text('loading...'),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.colorBurn,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0, bottom: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                daliy.headText,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  daliy.title,
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              Text(
                                daliy.footerText,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  daliy.content,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
