import 'package:flutter/material.dart';
import 'package:video_chat_app/core/constants.dart';
import 'package:video_chat_app/core/extensions/ex_num.dart';
import 'package:video_chat_app/features/home_feature/data/models/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CustomChatItem extends StatelessWidget {
  const CustomChatItem({super.key, required this.isOnline, required this.user});

  final UserModel user;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(user.name),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.image),
            radius: 25,
          ),
          trailing: ZegoSendCallInvitationButton(
            isVideoCall: true,
            //You need to use the resourceID that you created in the subsequent steps.
            //Please continue reading this document.
            resourceID: AppConstants.resourceID,
            invitees: [
              ZegoUIKitUser(
                id: user.uid,
                name: user.email,
              ),
            ],
            iconSize: Size(50,50),

          ),
          subtitle: Row(
            children: [
              Text(isOnline ? 'Online Now' : 'Offline Now'),
              8.horizontalSpace,
              CircleAvatar(
                backgroundColor: isOnline ? Colors.green : Colors.black,
                radius: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
