import 'package:flutter/material.dart';




class ChangeColor extends StatefulWidget {

  final ListTile listTile;
  final Color color;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  const ChangeColor({Key key,this.color,this.listTile,this.borderRadius,this.padding}) : super(key: key);

  @override
  _ChangeColorState createState() => _ChangeColorState();
}

class _ChangeColorState extends State<ChangeColor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: widget.borderRadius ??
            const BorderRadius.horizontal(
              right: Radius.circular(1000),
            ),
        // Needed for ripple effect clipping
        child: Material(
          type: MaterialType.transparency,
          child: ColoredBox(
            color:


            widget.listTile.selected
                ? Colors.red
                : Colors.transparent,
            child: widget.listTile,
          ),
        ),
      ),
    );
  }
}


