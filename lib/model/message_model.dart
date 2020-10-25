import 'package:hurryAgro/model/user_model.dart';

class Message{
  final User sender;
  final String time;
  final String text;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}
  List<Message> chats= [
    Message(
      sender: lorenzo,
      time: '5:30 PM',
      text: 'dwndiwndwd wd wdwdwd dwd wdwdwd \' dwdwdwdwdd wdwdwdwd',
      unread: true,
    ),
    Message(
      sender: joao,
      time: '5:30 PM',
      text: 'dwndiwndwd wd wdwdwd dwd wdwdwd \' dwdwdwdwdd wdwdwdwd',
      unread: false,
    ),
    Message(
      sender: currentUser,
      time: '5:30 PM',
      text: 'dwndiwndwd wd wdwdwd dwd wdwdwd \' dwdwdwdwdd wdwdwdwd',
      unread: true,
    ),
  ];

  List<Message> messsagens= [
    Message(
      sender: lorenzo,
      time: '5:30 PM',
      text: 'dwndiwndwd wd wdwdwd dwd wdwdwd \' dwdwdwdwdd wdwdwdwd',
      unread: false,
    ),
    Message(
      sender: lorenzo,
      time: '5:30 PM',
      text: 'dwndiwndwd wd wdwdwd dwd wdwdwd \' dwdwdwdwdd wdwdwdwd',
      unread: false,
    ),
    Message(
      sender: currentUser,
      time: '5:30 PM',
      text: 'dwndiwndwd wd wdwdwd dwd wdwdwd \' dwdwdwdwdd wdwdwdwd',
      unread: true,
    ),
  ];

