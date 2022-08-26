import 'package:flutter/material.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(onPressed: () {}, child: Text('PATCH NOTES', style: Theme.of(context).textTheme.button)),
        TextButton(onPressed: () {}, child: Text('SUPPORT', style: Theme.of(context).textTheme.button)),
      ],
    );
  }
}
