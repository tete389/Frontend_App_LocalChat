import 'package:flutter/material.dart';
import 'package:frontend/view/theme/customTheme.dart';

class ChatWindow extends StatefulWidget {
  const ChatWindow({Key? key, required this.massage, required this.sendByMe})
      : super(key: key);

  final String massage;
  final bool sendByMe;

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          left: widget.sendByMe ? 0 : 24,
          right: widget.sendByMe ? 24 : 0,
        ),
        alignment: widget.sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: widget.sendByMe
              ? EdgeInsets.only(left: 30)
              : EdgeInsets.only(right: 30),
          padding: EdgeInsets.only(top: 17, bottom: 70, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: widget.sendByMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomRight: Radius.circular(23),
                    ),
              color: widget.sendByMe
                  ? CustomTheme.primaryTheme
                  : CustomTheme.secondaryTheme),
          child: Text(
            widget.massage,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: CustomTheme.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
