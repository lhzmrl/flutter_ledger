import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LedgerAppBar extends StatelessWidget implements PreferredSizeWidget {

  LedgerAppBar(this.title, {this.backPage = "", this.actions});

  final String backPage;
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Icon(Icons.arrow_back),
              Text(backPage??"")
            ],
          ),
        ),
      ),
      title: Text(title),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}