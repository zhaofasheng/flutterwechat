import 'package:flutter/material.dart';
import 'package:we_chat/pages/photosList.dart';
import 'package:we_chat/utils/config.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PostEditPage extends StatefulWidget {
  const PostEditPage({super.key});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {

  //已选择图片列表
  List<AssetEntity> selectedAssests = [];

  //是否开始拖拽
  bool isDragNow = false;
  //是否将要删除
  bool isWillRemove = false;


  Future<void> _choicePhotos() async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        selectedAssets: selectedAssests,
        maxAssets: maxAssets,
      )
    );

    if(result == null){
      return;
    }
    setState(() {
      selectedAssests = result ?? [];
    });
  }

  //删除Bar
  Widget _buildRemoveBar(){
    return DragTarget<AssetEntity>(
      builder: (context,candidateData,rejectedData){
        return SizedBox(
          width: double.infinity,
          child: Container(
              height: 100,
              color: isWillRemove ?Colors.red : Colors.redAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //图标
                  Icon(Icons.delete,size: 32,color:Colors.white,),
                  Text(
                    "拖到此处删除",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
          ),
        );
      },


      onWillAccept: (data){
        setState(() {
          isWillRemove = true;
        });
        return true;
      },

      onAccept: (data){
        setState(() {
          selectedAssests.remove(data);
          isWillRemove = false;
        });
      },

      onLeave: (data){
        setState(() {
          isWillRemove = false;
        });
      },
    );
  }

  //主视图
  Widget _mainView(){
    return Column(
      children: [
        photoList(
          selectedPhotos: selectedAssests,
          onTap: (value){
            _choicePhotos();
            print('图片数量$value');
            },
          onDragBlock: (bool isDrag) {
              print('拖拽状态$isDrag');
              setState(() {
                isDragNow = isDrag;
              });
          },
        ),

        const Spacer(),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          '发布',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _mainView(),
      bottomSheet: isDragNow ? _buildRemoveBar() : null,
    );
  }
}

