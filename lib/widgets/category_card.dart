import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Icon icon;
  final Widget title;
  final Widget content;
  final bool ignorePadding;

  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.content,
    this.ignorePadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconTheme(
                    data: Theme.of(context).iconTheme.copyWith(size: 30),
                    child: icon,
                  ),
                ),
                DefaultTextStyle.merge(
                  style: Theme.of(context).textTheme.headline6,
                  child: title,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: (ignorePadding ? 0.0 : 48.0), bottom: 16.0),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
