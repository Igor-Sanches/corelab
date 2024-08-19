import 'package:corelab/cammon/widgets/buttons/custom_button_widget.dart';
import 'package:corelab/cammon/widgets/image/my_icon.dart';
import 'package:corelab/features/search/controller/search_controller.dart' as search;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../application/view/application_screen.dart';
import '../../../cammon/widgets/snackbar/custom_snackbar.dart';
import '../../../cammon/widgets/text_field/custom_text_field.dart';
import '../../../theme/light_theme.dart';
import '../../../utilities/dimensions.dart';
import '../../../utilities/styles.dart';
import '../widgets/search_result_widget.dart';

class SearchScreen extends StatefulWidget{
  String? queryText;

  SearchScreen({super.key, this.queryText});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _searchNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchNode.requestFocus();
    Get.find<search.SearchController>().getHistoryList();
    if(widget.queryText != null && widget.queryText!.isNotEmpty) {
      _actionSearch(true, widget.queryText!, true);
      _searchController.text = widget.queryText!;
    }
    super.initState();
  }

  void _actionSearch(bool isSubmit, String queryText, bool fromHome) {
    if(Get.find<search.SearchController>().isSearchMode || isSubmit) {
      if(queryText.isNotEmpty) {
        Get.find<search.SearchController>().searchData(queryText, fromHome);
      }else {
        showCustomSnackBar('Nnehum item encontrado');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationScreen(
      backgroundColor: backgroundAppColor,
      onRefresh: ()async{
        Get.find<search.SearchController>().searchData(_searchController.text.trim(), false);
      },
      onWillPop: ()async{
        if(Get.find<search.SearchController>().isSearchMode) {
          return true;
        }else {
          Get.find<search.SearchController>().setSearchMode(true);
          return false;
        }
      },
      child: GetBuilder<search.SearchController>(builder: (controller){
        _searchController.text = controller.searchText;
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor
              ),
              padding: const EdgeInsets.only(top: 70, left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back, color: Colors.white,)),
                  Expanded(child: CustomTextField(
                    controller: _searchController,
                    hintText: "Buscar",
                    focusNode: _searchNode,
                    inputAction: TextInputAction.search,
                    onSubmit: (text) => _actionSearch(true, _searchController.text.trim(), false),
                    prefixIconButton: !controller.isSearchMode ? TextButton(
                      onPressed: (){},
                      child: InkWell(
                        child: MyIcon(MyIconData.cancel),
                        onTap: (){
                          Get.find<search.SearchController>().setSearchMode(true);
                        },
                      ),
                    ) : null,
                  )),
                  if(!controller.isSearchMode)
                    CustomButtonWidget(
                      buttonText: 'Filtros',
                      backgroundColor: Colors.transparent,
                      onPressed: (){},
                    )
                ],
              ),
            ),
            Expanded(child: controller.isSearchMode ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
              child: SizedBox(width: Dimensions.webMaxWidth, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                controller.historyList.isNotEmpty ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    padding: const EdgeInsets.only(top: 25, left: 20,bottom: 10),
                    child: Text('Pesquisas recentes', style: mdSans.copyWith(
                        fontSize: 18,
                    )),
                  ),
                  InkWell(
                    onTap: () => controller.clearSearchAddress(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: 4),
                      child: Text('Limpar tudo'.tr, style: TextStyle(
                        fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor,
                      )),
                    ),
                  ),
                ]) : const SizedBox(),

                controller.historyList.isNotEmpty ? ListView.builder(
                  itemCount: controller.historyList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => controller.searchData(controller.historyList[index], false),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                                child: Row(
                                  children: [
                                    const Icon(Icons.history, color: Color(0xFF7C9094), size: 20,),
                                    const SizedBox(width: 10,),
                                    Text(
                                      controller.historyList[index],
                                      style: mdSans.copyWith(
                                          color: Color(0xFF7C9094),
                                          fontSize: 20,
                                      ),
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Theme.of(context).disabledColor, size: 20),
                            onPressed: () => controller.removeHistory(index),
                          )
                        ]),
                      ]),
                    );
                  },
                ) : Container(
                  margin: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                  child: Center(
                    child: Image.asset(MyIconData.searchPage, width: 200,),
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              ])),
            ) : SearchResultWidget(searchText: _searchController.text.trim()))

          ],
        );
      }),
    );
  }
}