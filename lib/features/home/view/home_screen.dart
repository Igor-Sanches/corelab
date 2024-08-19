import 'package:corelab/features/home/controller/product_controller.dart';
import 'package:corelab/helper/helpers.dart';
import 'package:corelab/structure/route_helper.dart';
import 'package:corelab/utilities/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../application/view/application_screen.dart';
import '../../../cammon/widgets/image/my_icon.dart';
import '../../../cammon/widgets/product_widget.dart';
import '../../../theme/light_theme.dart';
import '../../../utilities/styles.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Get.find<ProductController>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationScreen(
      backgroundColor: backgroundAppColor,
      onRefresh: ()async{
        await Get.find<ProductController>().getProducts();
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
            ),
            padding: const EdgeInsets.only(top: 70, left: 10, right: 10, bottom: 10),
            child: InkWell(
              onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  children: [
                    const Expanded(child: Text('Buscar', style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                    ),)),
                    Image.asset(MyIconData.search, width: 32, colorBlendMode: BlendMode.srcIn, color: primaryColor,)
                  ],
                ),
              ),
            )
          ),
          GetBuilder<ProductController>(builder: (controller){
            var productsModel = controller.products;
            if(productsModel == null){
              return Center(child: Helpers.loading());
            }
            return Expanded(child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: Container(
                      color: colorSubBackground,
                      padding: const EdgeInsets.only(top: 25, left: 30,bottom: 10),
                      child: Text('Últimos anúncios', style: mdSans.copyWith(
                          fontSize: 20,
                      ),),
                    )
                ),
                SliverList(delegate: SliverChildBuilderDelegate((c, index) {
                  var productModel = productsModel.elementAtOrNull(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: colorSubBackground,
                          width: double.maxFinite,
                          padding: const EdgeInsets.only(top: 10, left: 30,bottom: 10),
                          child: Text(productModel!.createAt.toDateAgo(), style: mdSans.copyWith(
                              fontSize: 16,
                          ),)
                        ),
                        Column(children: productModel.products.map((product) => Container(margin: const EdgeInsets.symmetric(vertical: 20),
                          child: ProductWidget(product: product),)).toList(),)
                      ],
                    ),
                  );
                }, childCount: productsModel.length))
              ],
            ));
          })
        ],
      ),
    );
  }
}