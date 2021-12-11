import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/providers/news.dart';
import 'package:news/screens/news_detail_screen.dart';
import 'package:news/screens/news_overview_screen.dart';
import 'package:news/theme.dart';
import 'package:provider/provider.dart';
void main() { 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white
    ));
    return MultiProvider(                                                                     
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => News(),
          ),
        ],
        child: MaterialApp(
          title: 'News',
          theme: theme(),
          home: const NewsOverviewScreen(),
          routes: {
          //   VerticalsOverviewScreen.routeName: (ctx) => VerticalsOverviewScreen(), 
            NewsDetailScreen.routeName: (ctx) => NewsDetailScreen(),
          //   GraphScreen.routeName: (ctx) => GraphScreen(),
          //   MapViewScreen.routeName: (ctx) => MapViewScreen(),
          },
        )
    );
  }
}
