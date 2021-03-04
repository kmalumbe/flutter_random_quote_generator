import 'package:flutter_random_quote_generator/QuoteModel.dart';
import 'package:http/http.dart' as http;

class Api {
  static String _uri = "https://type.fit/api/quotes";
  Future<List<Quote>> getQuotes() async {
    print("loading quotes...");
    try {
      final response = await http.get(
        Uri.encodeFull(_uri),
        headers: {"Accept": "application/json"},
      );
      if (response.statusCode == 200) {
        print("response quote: true");
        List<Quote> quoteList = quoteFromJson(response.body);
        // feenoteList.sort((a, b) => b.feenoteid.toString().compareTo(a.feenoteid.toString()));
        return quoteList;
      } else {
        return [];
      }
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }
}
