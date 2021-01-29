import 'package:flutter/material.dart';
import 'package:news_perfromance_app/src/blocs/comments_provider.dart';
import 'package:news_perfromance_app/src/blocs/stories_provider.dart';
import 'package:news_perfromance_app/src/screens/news_details.dart';
import 'package:news_perfromance_app/src/screens/news_list.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          // home: NewsList(),
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  MaterialPageRoute routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        final storiesBloc = StoriesProvider.of(context);
        storiesBloc.fetchTopIds();
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name.replaceFirst('/', ''));
        commentsBloc.fetchItemWithComments(itemId);
        return NewsDetail(itemId: itemId);
      });
    }
  }
}
