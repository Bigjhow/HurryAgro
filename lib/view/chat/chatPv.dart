import 'package:flutter/material.dart';
import 'package:hurryAgro/model/user_model.dart';
import 'package:hurryAgro/model/message_model.dart';

class ChatPv extends StatefulWidget {
  final User user;
  ChatPv({this.user});

  @override
  _ChatPvState createState() => _ChatPvState();
}

class _ChatPvState extends State<ChatPv> {
  _chatBubble ( Message message, bool isMe, isSameuser){
    if(isMe){
      return Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.80,
                      ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                       BoxShadow(
                       color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                     blurRadius: 5,
                       ),
                      ],
                    ),
                  child: Text(
                    message.text,
                     style: TextStyle(
                     
                    color: Colors.white,
                    )
            ),
                  ),
                  ),
                  !isSameuser ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                           message.time,
            style: TextStyle(
              fontSize: 12, 
            color: Colors.black45,)
          ),
          SizedBox(width:10),
                        Container(            
            decoration: BoxDecoration(
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
              radius: 15,
              backgroundImage: AssetImage(message.sender.imageUrl),
            ),
          ),      
          ],
                    ):
Container(child: null),
    
                ],
              );
    } else {
      return Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.80,
                      ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                       BoxShadow(
                       color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                     blurRadius: 5,
                       ),
                      ],
                    ),
                  child: Text(
                    message.text,
                     style: TextStyle(
                     
                    color: Colors.black54,)
            ),
                  ),
                  ),
                  !isSameuser ?
                    Row(
                      children: <Widget>[
                        Container(            
            decoration: BoxDecoration(
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
              radius: 15,
              backgroundImage: AssetImage(message.sender.imageUrl),
            ),
          ),
          SizedBox(width:10),
          Text(
            message.time,
             style: TextStyle(
              fontSize: 12, 
            color: Colors.black45,)
          )
          ],
                    ):
                    Container(child: null),
                ],
              ),


            ],
          );
    }
   
  }
  _sendMessageArea(){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 70,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.photo),
                    iconSize: 25,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){},
                  ),
                  Expanded(
                    child: TextField
                    (
                    decoration: InputDecoration.collapsed(
                      hintText: 'Sende a message',   
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  ),
                  
                  IconButton(
                    icon: Icon(Icons.send),
                    iconSize: 25,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){},
                  )
            ],)
                );
  }
  @override
  Widget build(BuildContext context) {
    int prevUserId;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.user.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              TextSpan(text: '\n'),
              widget.user.isOnline ?
              TextSpan(
                text: 'Online',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                ):
                TextSpan(
                text: 'Offline',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                ),
            ]
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
           onPressed: (){
          Navigator.pop(context);
        }),

      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(20),
              itemCount: messsagens.length,
              itemBuilder: (BuildContext context, int index){
                final Message message = messsagens[index];
                final bool isMe = message.sender.id == currentUser.id;
                final bool isSameuser = prevUserId == message.sender.id;
                prevUserId = message.sender.id;
                return _chatBubble(message, isMe, isSameuser);
              },
              )
          ),
          _sendMessageArea(),
          
        ],
      )
    );
  }
}