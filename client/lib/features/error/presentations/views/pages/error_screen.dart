import 'package:flutter/material.dart';

import '../../../../../core/widgets/title_text.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: titleText("Library"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Colors.black, height: 1),
        ),
      ),
      body: Center(child: Text("Some thing wrong!")),
    );
  }
}
