import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 19/07/21 at 4:18 pm
///

class HtmlView extends StatefulWidget {
  final String content;
  final Color color;
  const HtmlView(this.content, {this.color});

  @override
  _HtmlViewState createState() => _HtmlViewState();
}

class _HtmlViewState extends State<HtmlView> {
  @override
  Widget build(BuildContext context) {
    return Html(
      data: '${widget.content}',
      style: {
        "span": Style(color: widget.color),
        "div": Style(color: widget.color),
        "h1": Style(color: widget.color),
        "h2": Style(color: widget.color),
        "h3": Style(color: widget.color),
        "h4": Style(color: widget.color),
        "h6": Style(color: widget.color),
        "h5": Style(color: widget.color),
        "p": Style(color: widget.color),
      },
    );
  }
}
