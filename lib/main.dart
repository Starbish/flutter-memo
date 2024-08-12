import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'memo_data.dart';
import 'memo_memopage.dart';
import 'memo_listpage.dart';
//import 'memo_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemoProvider(),
      child: MaterialApp(
      
        theme: ThemeData (
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        
        home: const MemoApp_MainPage(),
      ),
    );
  }
}

class MemoApp_MainPage extends StatefulWidget {

  final String title = '메모장 프로그램';
  final int? id;
  const MemoApp_MainPage({super.key, this.id});

  @override
  State<MemoApp_MainPage> createState() => _MemoApp_MainPageState();
}

class _MemoApp_MainPageState extends State<MemoApp_MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Memo_ListPage()),
            );
          },
        ),
      ),

      body: MemoApp_MemoPage(id: widget.id ?? -1)
    );
  }
}