import 'package:corelab/cammon/widgets/image/my_icon.dart';
import 'package:flutter/material.dart';

class CustomImageWidget extends StatefulWidget {
  final String image;
  double? height;
  double? width;
  final BoxFit fit;
  String? placeholder;
  double? borderRadius;
  Function()? onTap;
  bool loading;
  bool placeholderIsVideo;
  bool placeholderIsImage;
  bool isCommunity;
  bool isAsset;

  CustomImageWidget({required this.image, this.borderRadius = 0, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = MyIconData.placeholder, this.onTap, this.loading = false, this.placeholderIsVideo = false, this.placeholderIsImage = false, this.isCommunity = false, this.isAsset = false});

  @override
  State<CustomImageWidget> createState() => _CustomImageWidgetState();
}

class _CustomImageWidgetState extends State<CustomImageWidget> {
  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: (){
        if(widget.onTap != null){
          widget.onTap!();
        }
      },
      child: Container(
        decoration: widget.onTap != null ? BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 3
            )
        ) : null,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                child: Image.asset(widget.image, height: widget.height, width: widget.width, fit: widget.fit,)),
            if(widget.onTap != null)
              Positioned(
                right: 1, bottom: 1,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).primaryColor.withOpacity(.8),
                    ),
                    child: Icon(Icons.edit, color: Theme.of(context).cardColor,)
                ),
              )
          ],
        ),
      ),
    );
  }

}
