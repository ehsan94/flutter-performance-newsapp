import 'package:flutter/material.dart';
import 'package:news_perfromance_app/src/blocs/stories_provider.dart';
import 'package:news_perfromance_app/src/models/item_model.dart';
import 'package:news_perfromance_app/src/widgets/loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
        stream: bloc.items,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }
          return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return LoadingContainer();
              }
              return buildTile(context, itemSnapshot.data);
            },
          );
        });
  }

  buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text(item.title),
          subtitle: Text('${item.score} votes'),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 6.0,
        ),
      ],
    );
  }
}
