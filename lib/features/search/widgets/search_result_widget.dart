import 'package:corelab/cammon/widgets/image/my_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../cammon/widgets/product_widget.dart';
import '../../../utilities/dimensions.dart';
import '../../../utilities/styles.dart';
import '../controller/search_controller.dart' as search;

class SearchResultWidget extends StatefulWidget {
  final String searchText;
  SearchResultWidget({required this.searchText});

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      GetBuilder<search.SearchController>(builder: (searchController) {
        bool isNull = true;
        int length = 0;
        isNull = searchController.searchStoreList == null;
        if(!isNull) {
          length = searchController.searchStoreList!.length;
        }
        return isNull ? const SizedBox() : Center(child: SizedBox(width: Dimensions.webMaxWidth, child: Container(
          padding: const EdgeInsets.only(top: 25, left: 30,bottom: 10),
          child: Row(children: [
            Text(
                length.toString(),
                style: mdSans.copyWith(
                    fontSize: 18
                )
            ),
            const SizedBox(width: 5),
            Expanded(child: Text('resultado encontrado'.trPlural('resultados encontrados', length), style: mdSans.copyWith(
                fontSize: 18,
            )
            ))
          ]),
        )));
      }),

      Expanded(child:GetBuilder<search.SearchController>(builder: (searchController){
        if(searchController.searchStoreList == null || searchController.searchStoreList!.isEmpty){
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50,),
                  Image.asset(MyIconData.searchQuery, width: 200,),
                  const SizedBox(height: 20,),
                  Text('Resultado não encontrado', style: mdSans.copyWith(
                      color: Colors.black,
                      fontSize: 20
                  ),),
                  Text('Não encontramos nenhum resultado parecido com "${widget.searchText}".', textAlign: TextAlign.center, style: mdSans.copyWith(
                      color: Colors.black54,
                      fontSize: 16
                  ),),
                ],
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: searchController.searchStoreList!.length,
          itemBuilder: (c, index){
            return ProductWidget(product: searchController.searchStoreList!.elementAt(index));
          }
        );
      }))]);
  }
}