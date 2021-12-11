import 'package:flutter/material.dart';
import 'package:news/providers/article.dart';
import 'package:news/providers/news.dart';
import 'package:provider/provider.dart';

import '../widgets/product_description.dart';
import '../widgets/top_rounded_container.dart';
import '../size_config.dart';

class NewsDetailScreen extends StatefulWidget {
  static const routeName = '/article/detail';

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late Widget _appBarTitle;
  var args;
  late Article article;
  late String type;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    args = ModalRoute.of(context)!.settings.arguments as List;
    article = Provider.of<News>(context).items[args[0]];
    return Scaffold(
            appBar: AppBar(
              elevation: 3,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            body: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Hero(
                        tag: article.title.toString(),
                        child: Image.network(
                          article.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  TopRoundedContainer(
                      color: Colors.white,
                      child: ProductDescription(article: article,)
                  ),
                  const SizedBox(),
                  // ListView.builder(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemCount: _filteredVertices.length,
                  //   itemBuilder: (ctx, i) {
                  //     return VertexItem(
                  //       index: i + 1,
                  //       vertex: _filteredVertices[i],
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          );
  }
}
