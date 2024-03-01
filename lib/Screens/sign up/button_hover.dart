import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/elevated_button.dart';

class ButtonOnHover extends StatefulWidget {
  final Widget child;
  const ButtonOnHover({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ButtonOnHover> createState() => _ButtonOnHoverState();
}

class _ButtonOnHoverState extends State<ButtonOnHover> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.1);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(true),
      child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: transform,
          child: widget.child),
    );
  }

  void onEntered(bool isHoverd) => setState(() {
        this.isHovered = isHoverd;
      });
}
