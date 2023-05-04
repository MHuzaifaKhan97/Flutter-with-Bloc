import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.warning_amber,
            size: 32,
          ),
          SizedBox(height: 6),
          Text(
            '',
            style: TextStyle(
                color: Colors.teal, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
