import 'package:flutter/material.dart';

class BottomActionButton extends StatelessWidget {
  final String textfootpage;
  final void Function() onTap;
  const BottomActionButton(
      {super.key, required this.textfootpage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: MediaQuery.sizeOf(context).width,
        color: const Color.fromRGBO(151, 117, 250, 1),
        height: 75 * MediaQuery.sizeOf(context).height / 812,
        child: Center(
          child: Text(
            textfootpage,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
