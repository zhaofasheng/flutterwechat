import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/pages/gallery.dart';
import 'package:we_chat/pages/photoView.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../utils/config.dart';

class photoList extends StatelessWidget {

  final void Function(int)? onTap;
  final void Function(bool)? onDragBlock;
  final List<AssetEntity> selectedPhotos;

  photoList({required this.selectedPhotos,required this.onTap,required this.onDragBlock});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(spacing),
      child: LayoutBuilder(
        builder: (BuildContext context,BoxConstraints constraints){
          final double width = (constraints.maxWidth - spacing*2)/3;
          return   Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for(final asset in selectedPhotos)
                photoView(
                  asset: asset,
                  width: width,
                  selectedPhotos: selectedPhotos,
                  onDragTap: (bool isDrage) {
                    onDragBlock?.call(isDrage);
                  },
                ),
              if(selectedPhotos.length < 6)
                GestureDetector(
                  onTap: (){
                    onTap?.call(selectedPhotos.length);
                  },
                  child: Container(
                    color: Colors.black12,
                    width: width,
                    height: width,
                    child: Icon(Icons.add,size: 48,),
                  ),
                )

            ],
          );
        },

      ),
    );
  }
}
