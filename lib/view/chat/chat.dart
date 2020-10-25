import 'package:flutter/material.dart';
import 'package:hurryAgro/model/message_model.dart';
import 'package:hurryAgro/model/user_model.dart';
import 'package:hurryAgro/view/chat/chatPv.dart';
import 'package:page_transition/page_transition.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: ListView.builder(
         itemCount: chats.length,
         itemBuilder: (BuildContext context, int index){
           final Message chat = chats[index];
        return GestureDetector(
          onTap: () => Navigator.push(
                context,
                PageTransition(
                    child: ChatPv(
                      user: chat.sender,
                    ),
                    type: PageTransitionType.rightToLeft,
                    )),
          child: Container(
          padding: EdgeInsets.all(10),
            child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            decoration: chat.unread ? BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
              //shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                )
              ]
            ):
            BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                )
              ]
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(chat.sender.imageUrl),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            padding: EdgeInsets.only(left: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Text(
                                  chat.sender.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    ),
                                ),
                                chat.sender.isOnline ?
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor,
                                  ),


                                ) :
                                Container(
                                  child: null,
                                ),
                                  ],
                                ),           
                                Text(
                                  chat.time,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black54,
                                    ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                      Container(alignment: Alignment.topLeft,
                      child: Text(                      
                        chat.text,
                                  style: TextStyle(
                                    fontSize: 13,                           
                                    color: Colors.black54,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                        ),),
              ],
            )                     
          ),
          
        ],
      ),
          ),);      
       },
       ),
    );
  }
}
