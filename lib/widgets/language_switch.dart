import 'package:flutter/material.dart';

class LanguageSwitch extends StatefulWidget {
  final String firstChildText;
  final String secondChildText;
  final Color backgroundColor;
  final Function(bool) onSelectionChanged;
  final int initialIndex;

  const LanguageSwitch({
    Key key,
    this.firstChildText,
    this.secondChildText,
    this.backgroundColor,
    this.onSelectionChanged,
    this.initialIndex,
  }) : super(key: key);

  @override
  _LanguageSwitchState createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<int> _animation;
  bool selection = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _animation = IntTween(begin: 100, end: 1).animate(_animationController);
    _animation.addListener(() => setState(() {}));

    if (widget.initialIndex == 1) {
      _animationController.forward(from: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 100, maxWidth: 200, minHeight: 40),
      child: Material(
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        color: widget.backgroundColor ?? Colors.white12,
        child: GestureDetector(
          onTap: _changeSelection,
          onPanEnd: (details) => _changeSelection(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SizedBox(width: _animation.value.clamp(0, 24).toDouble()),
                Expanded(
                  flex: _animation.value.clamp(1, 100),
                  child: Transform.translate(
                    offset: Offset((1 - _animation.value) / 100, 0),
                    child: Opacity(
                      opacity: _animation.value.clamp(0.0, 1.0).toDouble(),
                      child: Text(
                        widget.firstChildText.toUpperCase(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  flex: (100 - _animation.value).clamp(1, 100),
                  child: Transform.translate(
                    offset: Offset((100 - _animation.value) / 100, 0),
                    child: Opacity(
                      opacity: _animation.value.clamp(0.0, 1.0).toDouble(),
                      child: Text(
                        widget.secondChildText.toUpperCase(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: (100 - _animation.value).clamp(0, 24).toDouble()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _changeSelection() {
    _animationController.value == 0.0
        ? _animationController.forward()
        : _animationController.reverse();
    if (widget.onSelectionChanged != null)
      widget.onSelectionChanged(_animationController.value != 0.0);
  }
}
