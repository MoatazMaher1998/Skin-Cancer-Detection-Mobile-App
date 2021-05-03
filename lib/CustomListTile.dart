import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key key, @required this.title, @required this.ontap})
      : super(key: key);

  final String title;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: ontap,
    );
  }
}
