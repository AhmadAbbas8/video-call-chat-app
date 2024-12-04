import 'package:flutter/material.dart';
import 'package:video_chat_app/core/extensions/ex_num.dart';

class CustomChatItem extends StatelessWidget {
  const CustomChatItem({super.key, required this.name, required this.image, required this.isOnline});
  final String name ;
  final String image;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(name),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                image),
            radius: 25,
          ),
          trailing: Icon(
            Icons.call,
          ),
          subtitle: Row(
            children: [
              Text(isOnline?'Online Now':'Offline Now'),
              8.horizontalSpace,
              CircleAvatar(
                backgroundColor:isOnline? Colors.green:Colors.black,
                radius: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
