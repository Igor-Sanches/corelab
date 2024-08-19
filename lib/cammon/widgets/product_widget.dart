import 'package:auto_size_text/auto_size_text.dart';
import 'package:corelab/application/models/product.dart';
import 'package:corelab/utilities/extensions.dart';
import 'package:flutter/material.dart';

import '../../theme/light_theme.dart';
import 'image/custom_image_widget.dart';

class ProductWidget extends StatelessWidget{
  final Product product;

  const ProductWidget({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30, right: 20, top: 10),
          child: CustomImageWidget(image: product.imageProduct, width: 90,),
        ),
        Expanded(child: Column( mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(product.hasDiscount)
              Container(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8)
                ),
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Text('${product.discountPercentage} OFF', style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12
                ),),
              ),
            const SizedBox(height: 10,),
            AutoSizeText(product.description!, style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF002429)
            ), maxLines: 2, overflow: TextOverflow.ellipsis),

            if(product.hasDiscount)
              Text(product.price!.toPrice(), style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Color(0xFF002429),
                decoration: TextDecoration.lineThrough,
              )),
            Text(product.priceProduct.toPrice(), style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF002429)
            )),

            const Text("Em até 12x de R\$ 249,00", style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: primaryColor
            )),
            if(product.isNew!)
              const Text("NOVO", style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF002429)
              )),
          ],)),
        const SizedBox(width: 10,)
      ],
    );
  }

}