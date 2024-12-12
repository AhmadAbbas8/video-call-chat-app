import 'package:flutter/material.dart';
import 'package:video_chat_app/core/constants.dart';
import 'package:video_chat_app/core/extensions/ex_context.dart';
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZegoSendCallInvitationButton(
                isVideoCall: false,
                resourceID: AppConstants.resourceID,
                icon: ButtonIcon(
                  icon: Icon(Icons.call),
                  backgroundColor: Colors.green,
                ),
                invitees: [
                  ZegoUIKitUser(
                    id: user.uid,
                    name: user.email,
                  ),
                ],
                buttonSize: Size(30, 30),
                iconSize: Size(30, 30),
                onPressed: (code, message, p2) {
                  print('-----------------------------------------');
                  if (message.isNotEmpty) {
                    var splitMessage = message.split(',')[1].split(':')[1];
                    context.showSnackBar(SnackBar(content: Text(splitMessage)));
                  }
                },
                borderRadius: 10,
                notificationMessage: 'Call from ${user.name}',
                notificationTitle: 'Video Call',
              ),
              10.horizontalSpace,
              ZegoSendCallInvitationButton(
                isVideoCall: true,
                resourceID: AppConstants.resourceID,
                icon: ButtonIcon(
                  icon: Icon(Icons.video_call),
                  backgroundColor: Colors.green,
                ),
                invitees: [
                  ZegoUIKitUser(
                    id: user.uid,
                    name: user.email,
                  ),
                ],
                buttonSize: Size(30, 30),
                iconSize: Size(30, 30),
                onPressed: (code, message, p2) {
                  print('-----------------------------------------');
                  if (message.isNotEmpty) {
                    var splitMessage = message.split(',')[1].split(':')[1];
                    context.showSnackBar(SnackBar(content: Text(splitMessage)));
                  }
                },
                borderRadius: 10,
                notificationMessage: 'Call from ${user.name}',
                notificationTitle: 'Video Call',
              ),
            ],
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
