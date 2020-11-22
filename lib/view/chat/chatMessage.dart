import 'package:flutter/material.dart';
class chatMessage extends StatelessWidget {

  chatMessage(this.data, this.mine);
  final Map<String, dynamic> data;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: mine ? CrossAxisAlignment.end :CrossAxisAlignment.start,
              children: [
                data['imageUrl'] != null ?
                Image.network(data['imageUrl'], width: 250,):
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    data['text'],
                    textAlign: mine ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )
                )
                ),
                
              ],
            )
          )
        ],
      ),
    );
  }
}