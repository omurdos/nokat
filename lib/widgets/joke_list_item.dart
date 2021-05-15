import 'package:flutter/material.dart';

class JokeListItem extends StatelessWidget {
  final String text;
  Function onShare;
  Function onCopy;

  JokeListItem({@required this.text, @required this.onShare, @required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: Text(text, textDirection: TextDirection.rtl,)),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  icon: Icon(Icons.share),
                  onPressed: onShare,
                  label: Text("مشاركة"),
                ),
              ),

              Expanded(
                child: TextButton.icon(
                  icon: Icon(Icons.copy),
                  onPressed: onCopy,
                  label: Text("نسخ"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
