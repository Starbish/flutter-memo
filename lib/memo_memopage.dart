import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memo_data.dart';

class MemoApp_MemoPage extends StatefulWidget {

  final int id;
  const MemoApp_MemoPage({super.key, required this.id});

  @override
  State<MemoApp_MemoPage> createState() => _MemoApp_MemoPageState();
}

class _MemoApp_MemoPageState extends State<MemoApp_MemoPage> {
  
  // 제목, 메모 텍스트 컨트롤러
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    MemoProvider memoProvider = Provider.of<MemoProvider>(context, listen: false);
    Memo? memo = memoProvider.memoInstance(widget.id);

    // 메모 새 작성
    if(memo == null) {



    // 기존 메모를 수정하는 작성
    } else {

      // 컨트롤러로 텍스트 데이터 로딩하기
      _titleController.text = memo.title;
      _memoController.text = memo.content;

    }
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: '제목'),
          ),
          SizedBox(height: 8),

          TextField(
            controller: _memoController,
            decoration: InputDecoration(labelText: '메모 내용'),
            maxLines: 5,
          ),
          SizedBox(height: 16),

          // 저장버튼
          ElevatedButton(
            child: Text(memo != null ? '메모 수정' : '메모 추가'),
            onPressed: () {
              // 메모 제목이나 내용 중 하나라도 채워졌다면, 저장 가능
              if( _titleController.text.isNotEmpty || _memoController.text.isNotEmpty ) {

                // 새 메모 작성인 경우
                if(memo == null) {
                  memoProvider.addMemo(
                    title: _titleController.text, 
                    content: _memoController.text, 
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('메모가 추가되었습니다.')),
                  );
                // 메모 수정인 경우
                } else {
                  memoProvider.editMemo(
                    id: widget.id,
                    title: _titleController.text, 
                    content: _memoController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('메모가 수정되었습니다.')),
                  );

                  Navigator.pop(context);
                }
              }
                // 컨트롤러 초기화
                _titleController.clear();
                _memoController.clear();
            }
          ),
        ],
      )
    );
  }
}