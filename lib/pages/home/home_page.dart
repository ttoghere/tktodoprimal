import 'package:flutter/material.dart';
import 'package:tktodoprimal/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/homepage";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
    );
  }
}
