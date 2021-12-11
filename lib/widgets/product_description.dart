import 'package:flutter/material.dart';
import 'package:news/providers/article.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            article.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            article.content,
            // maxLines: 3,
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: ElevatedButton(
              onPressed: () => launch(article.url),
              child: const Text("Open Full Article")),
        ),
      ],
    );
  }
}
