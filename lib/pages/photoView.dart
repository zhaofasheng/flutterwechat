import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/utils/config.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'gallery.dart';

class photoView extends StatelessWidget {
  const photoView({super.key, required this.asset, required this.width, required this.selectedPhotos,required this.onDragTap,required this.onOrderTap,required this.onAcceptTap, required this.isWillOrder, required this.targetAeeseId});

  final AssetEntity asset;
  final double width;
  final List<AssetEntity> selectedPhotos;
  final void Function(bool)? onDragTap;
  final void Function(bool,String)? onOrderTap;
  final void Function(AssetEntity,AssetEntity)? onAcceptTap;
  final bool isWillOrder;
  //被拖拽的id
  final String targetAeeseId;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: asset,

      //结束拖动
      onDragEnd: (details){
        onDragTap?.call(false);
        onOrderTap?.call(false,"");
      },

      //开始拖动
      onDragStarted: (){
        onDragTap?.call(true);
      },

      onDraggableCanceled: (velocity,offset){
        onDragTap?.call(false);
        onOrderTap?.call(false,"");
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
      child: DragTarget<AssetEntity>(
        onWillAccept: (data){
          onOrderTap?.call(true,asset.id);
          print('拖拽对象$data.id   目标对象$asset.id');
          return true;
        },

        onAccept: (data){
          onAcceptTap?.call(data,asset);
        },

        onLeave: (data){
          onOrderTap?.call(false,"");
        },

        builder: (context,canidateDate,rejectedData){

          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return GalleryWidget(initialIndex: selectedPhotos.indexOf(asset), items: selectedPhotos, isBarVisible: true);
              }));
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              padding: (isWillOrder && targetAeeseId == asset.id) ? EdgeInsets.zero : EdgeInsets.all(imagePadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                border: (isWillOrder && targetAeeseId == asset.id) ? Border.all(
                  color: accentColor,
                  width: imagePadding,
                ) : null,
              ),
              child: AssetEntityImage(
                asset,
                width: width,
                height: width,
                fit: BoxFit.cover,
                isOriginal: false,
              ),
            ),
          );
        },
      ),
    );

  }
}
