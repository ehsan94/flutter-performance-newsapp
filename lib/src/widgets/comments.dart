import 'package:flutter/material.dart';
import 'package:news_perfromance_app/src/models/item_model.dart';

class Comments extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  const Comments({this.itemId, this.itemMap, this.depth});
  final int depth;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return Text('Still loading comment');
        }
        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: Text(item.text),
            subtitle: item.by == "" ? Text("Deleted") : Text(item.by),
            contentPadding:
                EdgeInsets.only(right: 16.0, left: (depth + 1) * 16.0),
          ),
          Divider(),
        ];

        item.kids.forEach((kidId) {
          children.add(Comments(
            itemId: itemId,
            itemMap: itemMap,
            depth: (depth) + 1,
          ));
        });
        return Column(
          children: children,
        );
      },
    );
  }
}
