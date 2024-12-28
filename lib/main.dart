// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/quiz_page.dart';
import 'bloc/quiz_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc(),
      child: MaterialApp(
        title: 'Quiz App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.indigo,
        ),
        home: const QuizPage(title: 'Quiz app'),
      ),
    );
  }
}