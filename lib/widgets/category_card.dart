import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryCard extends StatefulWidget {
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
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  Animation<double> _doubleAnimation;
  Locale locale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _offsetAnimation = Tween<Offset>(
            begin: const Offset(0.0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _doubleAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    if (locale == null) {
      locale = context.locale;
      _controller.forward();
    } else if (locale != context.locale) {
      locale = context.locale;
      _controller.reverse(from: 0.4).then((value) => _controller.forward());
    }
    return FadeTransition(
      opacity: _doubleAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Card(
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
                        child: widget.icon,
                      ),
                    ),
                    DefaultTextStyle.merge(
                      style: Theme.of(context).textTheme.headline6,
                      child: widget.title,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: (widget.ignorePadding ? 0.0 : 48.0), bottom: 16.0),
                  child: widget.content,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
