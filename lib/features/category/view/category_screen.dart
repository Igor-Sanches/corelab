import 'package:auto_size_text/auto_size_text.dart';
import 'package:corelab/helper/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../application/view/application_screen.dart';
import '../../../cammon/widgets/image/custom_image_widget.dart';
import '../../../cammon/widgets/image/my_icon.dart';
import '../../../cammon/widgets/text_field/custom_text_field.dart';
import '../../../theme/light_theme.dart';
import '../../../utilities/styles.dart';
import '../controller/category_controller.dart';

class CategoryScreen extends StatefulWidget{
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  @override
  void initState() {
    Get.find<CategoryController>().getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationScreen(
      backgroundColor: backgroundAppColor,
      onRefresh: ()async{
        await Get.find<CategoryController>().getCategories();
      },
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 70, left: 30,bottom: 10),
              width: double.maxFinite,
              color: colorSubBackground,
              child: Text('Categorias', style: mdSans.copyWith(
                  fontSize: 24,
              ),)
          ),
          GetBuilder<CategoryController>(builder: (controller){
            var categories = controller.categories;
            if(categories == null){
              return Center(child: Helpers.loading());
            }
            return Expanded(child: CustomScrollView(
              slivers: [
                SliverList(delegate: SliverChildBuilderDelegate((c, index) {
                  var productModel = categories.elementAtOrNull(index);
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, left: 30,bottom: 10),
                    child: TextButton(
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Text(productModel!.category!, style: mdSans.copyWith(
                            fontSize: 20,
                        ), textAlign: TextAlign.start,),
                      ),
                      onPressed: (){

                      },
                    ),
                  );
                }, childCount: categories.length))
              ],
            ));
          })
        ],
      ),
    );
  }
}