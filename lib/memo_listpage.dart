import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'memo_data.dart';
import 'main.dart';

class Memo_ListPage extends StatefulWidget {
  const Memo_ListPage({super.key});

  @override
  State<Memo_ListPage> createState() => _Memo_ListPageState();
}

class _Memo_ListPageState extends State<Memo_ListPage> {
  @override
  Widget build(BuildContext context) {
    final memoProvider = Provider.of<MemoProvider>(context);
    final memoList = memoProvider.memoList; 

    return Scaffold(
      appBar: AppBar(
        title: Text('메모 목록'),
      ),

      body: ListView.builder(
        itemCount: memoList.length,
        itemBuilder: (content, index) {
          final memo = memoList[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            // 자식을 InkWell로 함으로써 memo Card 하나하나도 상호작용 가능하게
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoApp_MainPage(id: memoList[index].id),
                  ),
                );
/*
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('ID = ${memoList[index].id}, INDEX = ${index}')),
                );
*/
              },
              child: ListTile(
                leading: IconButton(
                  // 중요도 표시
                  icon: Icon(
                    memo.isMarked ? Icons.star : Icons.star_border,
                    color: memo.isMarked? Colors.yellow : Colors.black,
                  ),
                  onPressed: () {
                    memoProvider.onPressMarkButton(memoList[index].id);
                    // 이미 onPressMarkButton 에서 새로고침하므로 필요없음
                    // setState(() {});
                  },
                ),

                title: Text(memo.title),
                subtitle: Text(
                  memo.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // 삭제 버튼
                    //memoProvider.deleteMemo(memoList[index].id);
                    showDialog(
                      context: context, 
                      barrierDismissible: false,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          content: Text("정말 삭제할까요?"),
                          actions: [
                            ElevatedButton(
                              child: Text("예"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                memoProvider.deleteMemo(memoList[index].id);
                              }
                            ),
                            ElevatedButton(
                              child: Text("아니오"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }
                            )
                          ]
                        );
                      }
                    );
                  },
                ),
              )
            )
          );
        },
      ),

      // 메모 목록 페이지에서 새 메모 작성(메인페이지와 동일)으로 갈 수 있는 기능
      // 우측 하단의 플러스 버튼
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        iconSize: 60.0,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MemoApp_MainPage();
              }
            )
          );
        },
      ),
    );
  }
}