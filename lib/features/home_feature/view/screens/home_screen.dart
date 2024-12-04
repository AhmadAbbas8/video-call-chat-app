import 'package:flutter/material.dart';

import '../widget/custom_chat_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat With Friends 🔥'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemBuilder: (context, index) => const CustomChatItem(
            image:
                'https://th.bing.com/th/id/OIP.z6mejm1rZ-RJ9wxhdSm6qAAAAA?rs=1&pid=ImgDetMain',
            isOnline: false,
            name: 'Ahmad Abbas',
          ),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: 14,
        ),
      ),
    );
  }
}
