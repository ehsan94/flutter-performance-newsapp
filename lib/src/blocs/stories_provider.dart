import 'package:flutter/widgets.dart';
import 'package:news_perfromance_app/src/blocs/stories_bloc.dart';

export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  static StoriesBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StoriesProvider>().bloc;
  }

  @override
  bool updateShouldNotify(_) {
    return true;
  }
}
