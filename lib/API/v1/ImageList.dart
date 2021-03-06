import 'package:chryssibooru/API/v2/API.dart';
import 'package:chryssibooru/Connect.dart';
import 'package:flutter/foundation.dart';


Future<List<Derpi>> searchImages(String query, bool s, bool q, bool e, String key, [int page = 1, int limit = 30]) {
  const api_url = "https://derpibooru.org/search.json?";

  var ratingsArr = [];
  if (s) ratingsArr.add("safe");
  if (q) ratingsArr.add("questionable");
  if (e) ratingsArr.add("explicit");
  var ratings = ratingsArr.join(" OR ");

  var queryString = api_url + "q=" + query;

  if ( !( (s&&q&&e) || (!s&&!q&&!e) ) ) queryString += "%2C (" + ratings + ")";
                                queryString += "&page="    + page.toString();
  if (key != "" || key != null) queryString += "&key="     + key;
  if (key == "" || key == null) queryString += "&perpage=" + limit.toString();

  var escapedQuery = queryString.replaceAll(" ", "+");

  var derpis = fetchDerpi(escapedQuery);

  debugPrint(derpis != null ? escapedQuery : 'End of results');

  return derpis;
}

Future<Derpi> getRandomImage(String query) {
  String apiUrl = "https://derpibooru.org/search.json?q=";
  apiUrl += query.replaceAll(' ', '+');
  apiUrl += '%2Cscore.gt:10&random_image=y';
  return fetchSingleDerpi(apiUrl);
}