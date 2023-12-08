import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swamy_bloc_learn/home/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
          appBarTheme: Theme.of(context)
              .appBarTheme
              .copyWith(systemOverlayStyle: SystemUiOverlayStyle.dark),
      ),
      home: const MyHomePage(),
    );
  }
}

