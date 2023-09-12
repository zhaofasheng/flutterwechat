import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'gallery.dart';

class photoView extends StatelessWidget {
  const photoView({super.key, required this.asset, required this.width, required this.selectedPhotos,required this.onDragTap});

  final AssetEntity asset;
  final double width;
  final List<AssetEntity> selectedPhotos;
  final void Function(bool)? onDragTap;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: asset,

      //结束拖动
      onDragEnd: (details){
        onDragTap?.call(false);
      },

      //开始拖动
      onDragStarted: (){
        onDragTap?.call(true);
      },

      onDragCompleted: (){

      },

      onDraggableCanceled: (velocity,offset){
        onDragTap?.call(false);
      },

      //拖拽视图
      feedback: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0)
        ),
        child: AssetEntityImage(
          asset,
          width: width,
          height: width,
          fit: BoxFit.cover,
          isOriginal: false,
        ),
      ),

      //拖拽时候的占位图
      childWhenDragging:Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0)
        ),
        child: AssetEntityImage(
          asset,
          width: width,
          height: width,
          fit: BoxFit.cover,
          isOriginal: false,
          opacity: const AlwaysStoppedAnimation(0.1),
        ),
      ),

      //图片视图
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return GalleryWidget(initialIndex: selectedPhotos.indexOf(asset), items: selectedPhotos, isBarVisible: true);
          }));
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0)
          ),
          child: AssetEntityImage(
            asset,
            width: width,
            height: width,
            fit: BoxFit.cover,
            isOriginal: false,
          ),
        ),
      ),
    );

  }
}
