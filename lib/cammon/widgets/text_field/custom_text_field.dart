import 'package:corelab/cammon/widgets/image/my_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utilities/dimensions.dart';

class CustomTextField extends StatefulWidget {
  String hintText;
  final TextEditingController controller;
  FocusNode? focusNode;
  FocusNode? nextFocus;
  TextInputType inputType;
  TextInputAction inputAction;
  bool isPassword;
  Function? onChanged;
  Function? onSubmit;
  bool isEnabled;
  int maxLines;
  TextCapitalization capitalization;
  String? prefixIcon;
  Widget? prefixIconButton;
  double prefixSize;
  bool divider;
  TextAlign textAlign;
  bool isAmount;
  bool isNumber;
  bool showTitle;
  Color? backgroundColor;
  bool? readOnly;
  Null Function()? onClick;

  CustomTextField(
      {super.key, this.hintText = 'Write something...',
        required this.controller,
        this.focusNode,
        this.prefixIconButton,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onSubmit,
        this.onChanged,
        this.prefixIcon,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.prefixSize = Dimensions.paddingSizeSmall,
        this.divider = false,
        this.textAlign = TextAlign.start,
        this.isAmount = false,
        this.isNumber = false,
        this.showTitle = false, this.backgroundColor, this.readOnly = false, this.onClick
      });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        widget.showTitle ? Text(widget.hintText, style: TextStyle(fontSize: Dimensions.fontSizeSmall)) : SizedBox(),
        SizedBox(height: widget.showTitle ? Dimensions.paddingSizeExtraSmall : 0),

        TextField(
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlign: widget.textAlign,
          style: TextStyle(fontSize: Dimensions.fontSizeLarge),
          textInputAction: widget.inputAction,
          keyboardType: widget.isAmount ? TextInputType.number : widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled || !widget.readOnly!,
          autofocus: false,
          onTap: (){
            if(widget.onClick != null){
              widget.onClick!();
            }
          },
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
              : widget.isAmount ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))] : widget.isNumber ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))] : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              borderSide: const BorderSide(style: BorderStyle.none, width: 0),
            ),
            isDense: true,
            hintText: widget.hintText,
            fillColor: widget.backgroundColor ?? Theme.of(context).cardColor,
            hintStyle: TextStyle(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor),
            filled: true,
            suffixIcon: widget.prefixIconButton ?? (widget.prefixIcon == null ? null : Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(widget.prefixIcon!, height: 20, width: 20, colorBlendMode: BlendMode.srcIn, color: Theme.of(context).primaryColor,),
            ))
          ),
          onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null ? widget.onSubmit!(text) : null,
          onChanged: (text){
            if(widget.onChanged != null){
              widget.onChanged!(text);
            }
          },
        ),

        widget.divider ? const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall), child: Divider()) : SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}