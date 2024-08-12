import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Memo {
  int id;
  String title;
  String content;
  DateTime createdDate;
  DateTime recentEditDate;
  bool isMarked;

  Memo({
    required this.id,
    required this.title,
    required this.content,
    required this.createdDate,
    required this.recentEditDate,
    required this.isMarked,
  });
}

class MemoProvider with ChangeNotifier {

  int id_increment = 0;
  final List<Memo> _memoList = [];

  List<Memo> get memoList => _memoList;
/* 
  Memo memoInstance(int index) {
    return _memoList[index];
  }
*/ 
  Memo? memoInstance(int id) {

    final int index = this.getIndexFromId(id);
    if( index >= _memoList.length || index < 0 )
      return null;

    return _memoList[index];
  }

  int getIndexFromId(int id) {
    for(int i = 0; i < _memoList.length; i++) {
      if(_memoList[i].id == id) {
        return i;
      }
    }

    // not found
    return -1;
  }
  
  // 리스트에 메모를 add 함 (새로 추가)
  void addMemo({required title, required content}) {

    Memo memo = Memo(
      id: id_increment, 
      title: title,
      content: content,
      createdDate: DateTime.now(),
      recentEditDate: DateTime.now(),
      isMarked: false
    );

    // id
    id_increment++;

    memoList.add(memo);
    notifyListeners();
  }

  void editMemo({required id, required title, required content}) {

    final int index = this.getIndexFromId(id);

    Memo memo = memoList[index];
    memo.title = title;
    memo.content = content;
    memo.recentEditDate = DateTime.now();
    
    notifyListeners();
  }

  void deleteMemo(int id) {

    final int index = this.getIndexFromId(id);

    memoList.removeAt(index);
    notifyListeners();
  }

  void onPressMarkButton(int id) {
    
    final int index = this.getIndexFromId(id);

    Memo memo = memoList[index];
    memo.isMarked = !memo.isMarked;

    notifyListeners();
  }
}