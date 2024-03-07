import 'package:flutter/material.dart';

class DashPage extends StatefulWidget {
  const DashPage({super.key});

  @override
  State<DashPage> createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        "DashBoard",
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
