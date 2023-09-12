
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/pages/appbar.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

//图片浏览器
class GalleryWidget extends StatefulWidget {
  const GalleryWidget(
      {super.key,
        required this.initialIndex,
        required this.items,
        required this.isBarVisible
      }
      );

  //初始图片位置
  final int initialIndex;
  //图片列表
  final List<AssetEntity>items;
  //是否显示bar
  final bool isBarVisible;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget>  with SingleTickerProviderStateMixin{
//SingleTickerProviderStateMixin防止界面外动画

  bool visible = true;
  //动画控制器
  late final AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = widget.isBarVisible ?? true;
    controller = AnimationController(
      vsync:this,
      duration: Duration(milliseconds: 200),
    );
  }

  Widget _buildImageView(){
    return ExtendedImageGesturePageView.builder(
      itemCount: widget.items.length,
      controller: ExtendedPageController(
        initialPage: widget.initialIndex,
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = widget.items[index];
        return ExtendedImage(
          image: AssetEntityImageProvider(
              item,
              isOriginal: true
          ),
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: ((state){
            return GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
              inPageView: true,//是否使用 ExtendedImageGesturePageView 展示图片
            );
          }),
        );
      }
    );
  }

  Widget _mainView(){
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap:(){
        //Navigator.pop(context);
        setState(() {
          visible = !visible;
        });
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: _buildImageView(),
        appBar: SliAppBarWidget(
          controller: controller,
          visible: visible,
          child:AppBar(
            leading:BackButton(
              color: Colors.white,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }
}

