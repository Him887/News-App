import 'package:flutter/material.dart';
import 'package:news/providers/news.dart';
import 'package:news/widgets/news_grid.dart';
import 'package:provider/provider.dart';


class NewsOverviewScreen extends StatefulWidget {
  static const routeName = "/News";

  const NewsOverviewScreen({Key? key}) : super(key: key);
  @override
  _NewsOverviewScreenState createState() =>
      _NewsOverviewScreenState();
}

class _NewsOverviewScreenState extends State<NewsOverviewScreen> {
  var _isInit = true;
  var _isloading = false;
  String _searchText = "popular";
  Icon _searchIcon = const Icon(Icons.search);
  late Widget _appBarTitle;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      _appBarTitle = const Text("News");
      Provider.of<News>(context).fetchAndSetNews("popular").then((value) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  void _searchPressed() {
    if (_searchIcon.icon == Icons.search) {
      _searchIcon = const Icon(Icons.close);
      _appBarTitle = TextField(
        onSubmitted: (value) {
          setState(() {
            _isloading = true;
          });
          if (value.isEmpty) {
            Provider.of<News>(context, listen: false).fetchAndSetNews("popular").then((value) {
              setState(() {
                _isloading = false;
                _searchText = "popular";
              });
            });
          } else {
            Provider.of<News>(context, listen: false).fetchAndSetNews(value.toLowerCase()).then((_) {
              setState(() {
                _isloading = false;
                _searchText = value.toLowerCase();
              });
            });
          }
        },
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: 'Search...'),
      );
    } else {
      _searchIcon = const Icon(Icons.search);
      _appBarTitle = const Text("News");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: _appBarTitle, 
              backgroundColor: Colors.white,
              titleTextStyle: const TextStyle(
                color: Color(0XFF8B8B8B), fontSize: 18
              ),
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              actions: [
              IconButton(
                icon: _searchIcon,
                onPressed: _searchPressed,
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    _isloading = true;
                  });
                  Provider.of<News>(context, listen: false).fetchAndSetNews(_searchText).then((value) {
                    setState(() {
                      _isloading = false;
                      _searchText = "";
                    });
                  });
                },
              ),
            ]),
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : NewsGrid(),
    );
  }
}
