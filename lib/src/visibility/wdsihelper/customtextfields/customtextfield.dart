import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String title;
  String subTitle;
  Icon prefixIcon;
  Icon sufixIcon;
  double textSize;

  CustomTextField(
      {@required this.title = 'title',
      @required this.subTitle = 'Subtitle',
      this.prefixIcon,
      this.sufixIcon,
      this.textSize = 1.1});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0, left: 5.0),
            child: prefixIcon != null ? prefixIcon : null,
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title ?? null,
                    textScaleFactor: 1.0,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5),
                  child: Wrap(alignment: WrapAlignment.end, children: <Widget>[
                    new Text(subTitle ?? null,
                        textScaleFactor: textSize ?? null,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54)),
                  ]),
                ),
              ],
            ),
            alignment: Alignment.centerLeft,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: sufixIcon != null ? sufixIcon : null,
          ),
        ],
      ),
      padding: EdgeInsets.all(8.0),
    );
  }
}
