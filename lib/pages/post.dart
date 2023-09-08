import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PostEditPage extends StatefulWidget {
  const PostEditPage({super.key});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布'),
      ),
      body: _mainView(),
    );
  }

  //主视图
  Widget _mainView(){
    return Column(
      children: [
        //选取图片按钮
        ElevatedButton(
            onPressed: () async {
              final List<AssetEntity>? result = await AssetPicker.pickAssets(context);
            },
            child: Text('选取图片')
        )
      ],
    );
  }
}

