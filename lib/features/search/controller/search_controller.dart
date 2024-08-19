import 'package:corelab/application/models/product.dart';
import 'package:corelab/cammon/widgets/snackbar/custom_snackbar.dart';
import 'package:get/get.dart';

import '../repository/search_repository.dart';

class SearchController extends GetxController implements GetxService{
  final SearchRepository repository;

  SearchController({required this.repository});

  List<Product>? _searchStoreList;
  List<Product>? _allStoreList;
  String _searchText = '';
  String _storeResultText = '';
  double _lowerValue = 0;
  double _upperValue = 0;
  List<String> _historyList = [];
  bool _isSearchMode = true;
  final List<String> _sortList = ['ascending'.tr, 'descending'.tr];
  int _sortIndex = -1;
  String _searchHomeText = '';

  List<Product>? get searchStoreList => _searchStoreList;
  String get searchText => _searchText;
  double get lowerValue => _lowerValue;
  double get upperValue => _upperValue;
  bool get isSearchMode => _isSearchMode;
  List<String> get historyList => _historyList;
  List<String> get sortList => _sortList;
  int get sortIndex => _sortIndex;
  String get searchHomeText => _searchHomeText;

  void setSearchMode(bool isSearchMode) {
    _isSearchMode = isSearchMode;
    if(isSearchMode) {
      _searchText = '';
      _storeResultText = '';
      _allStoreList = null;
      _searchStoreList = null;
      _sortIndex = -1;
      _upperValue = 0;
      _lowerValue = 0;
    }
    update();
  }

  void setLowerAndUpperValue(double lower, double upper) {
    _lowerValue = lower;
    _upperValue = upper;
    update();
  }

  void sortStoreSearchList() {
    _searchStoreList = [];
    _searchStoreList!.addAll(_allStoreList!);

    if(_sortIndex != -1) {
      if(_sortIndex == 0) {
        _searchStoreList!.sort((a, b) => a.description!.toLowerCase().compareTo(b.description!.toLowerCase()));
      }else {
        _searchStoreList!.sort((a, b) => a.description!.toLowerCase().compareTo(b.description!.toLowerCase()));
        Iterable iterable = _searchStoreList!.reversed;
        _searchStoreList = iterable.toList() as List<Product>;
      }
    }
    update();
  }

  void setSearchText(String text) {
    _searchText = text;
    update();
  }

  void searchData(String query, bool fromHome) async {
    if((query.isNotEmpty && query != _storeResultText) || (query.isNotEmpty || fromHome)) {
      _searchHomeText = query;
      _searchText = query;
      _upperValue = 0;
      _lowerValue = 0;
      _searchStoreList = null;
      _allStoreList = null;
      if (!_historyList.contains(query)) {
        _historyList.insert(0, query);
      }
      repository.saveSearchHistory(_historyList);
      _isSearchMode = false;
      if(!fromHome) {
        update();
      }

      List<Product>? response = await repository.getSearchData(query);

      bool hasProducts = response != null;

      if(hasProducts){
        if (query.isEmpty) {
          _searchStoreList = [];
        } else {
          _storeResultText = query;
          _searchStoreList = [];
          _allStoreList = [];
          _searchStoreList!.addAll(response);
          _allStoreList!.addAll(response);
        }
      }

      update();
    }
  }

  void getHistoryList() {
    _isSearchMode = true;
    _searchText = '';
    _historyList = [];
    _historyList.addAll(repository.getSearchAddress());
  }

  void removeHistory(int index) {
    _historyList.removeAt(index);
    repository.saveSearchHistory(_historyList);
    update();
  }

  void clearSearchAddress() async {
    repository.clearSearchHistory();
    _historyList = [];
    update();
  }

  void setSortIndex(int index) {
    _sortIndex = index;
    update();
  }

  void resetFilter() {
    _upperValue = 0;
    _lowerValue = 0;
    _sortIndex = -1;
    update();
  }

  void clearSearchHomeText() {
    _searchHomeText = '';
    update();
  }

}