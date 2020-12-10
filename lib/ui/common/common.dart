import 'package:flutter/material.dart';

class ThemedText extends StatelessWidget {
  final String _text;
  final double _fontSize;
  final Color _color;
  FontWeight _weight = FontWeight.normal;

  ThemedText(this._text, this._fontSize, this._color, {weight}) {
    this._weight = weight;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      this._text,
      style: TextStyle(color: _color, fontSize: _fontSize, fontWeight: _weight),
    );
  }
}
