import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({
    super.key,
    required this.callID,
    required this.userId,
    required this.userName,
  });

  final String callID;
  final String userId;

  final String userName;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1498646848,
      // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          '4ffb7a8d515ec77627d37c8672f810c2161cf9a59be4fbe6d17781d0ee0a43f4',
      // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userId,
      userName: userName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
