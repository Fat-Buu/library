import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/widgets/title_text.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () {
                context.goNamed(AppRoutes.login);
              },
              child: Text("Get Started", style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Human \nstories \n&ideas",
              style: TextStyle(
                height: 0.9,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "A place to read, write, and deepen your understanding",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green),
              ),
              onPressed: () {
                context.goNamed(AppRoutes.bookList);
              },
              child: Text(
                "Start reading",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 50,
        child: Row(
          children: [
            SizedBox(width: 25),
            Text("About", style: TextStyle(color: Colors.white)),
            SizedBox(width: 25),
            Text("Help", style: TextStyle(color: Colors.white)),
            SizedBox(width: 25),
            Text("Terms", style: TextStyle(color: Colors.white)),
            SizedBox(width: 25),
            Text("Privacy", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
