import 'dart:math';

import 'package:flutter_random_quote_generator/ApiService.dart';
import 'package:get/get.dart';

import 'QuoteModel.dart';

class Controller extends GetxController{
  final Api api = Get.put(Api());
  var loading = false.obs;
  List<Quote> quoteList = [];
  Quote quote;
  Random random = Random();
  @override
  void onInit() async{
    await fetchQuotes();
    if(quoteList.isNotEmpty) {
      quote = quoteList[random.nextInt(quoteList.length)];
    }

    super.onInit();
  }

  Future<List<Quote>> fetchQuotes() async {
    loading(true);
    quoteList = await api.getQuotes();
    if (quoteList != null){
      loading(false);
      return quoteList;
    }
    loading(false);

  }
}