import 'dart:convert';

import 'package:api_exp_352/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<DataModel> getQuotes() async {
    String url = "https://dummyjson.com/quotes";

    var res = await http.get(Uri.parse(url));

    Map<String, dynamic> mData = jsonDecode(res.body);

    print(mData);

    DataModel allData = DataModel.fromJson(mData);

    return allData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quotes'),
        ),
        body: FutureBuilder(
            future: getQuotes(),
            builder: (_, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snap.hasError) {
                return Center(
                  child: Text("${snap.error}"),
                );
              }

              if (snap.hasData) {
                List<QuoteModel> allQuotes = snap.data!.quotes;
                return ListView.builder(
                    itemCount: allQuotes.length,
                    itemBuilder: (_, index) {
                      QuoteModel eachQuote = allQuotes[index];

                      return Card(
                        child: ListTile(
                          title: Text(eachQuote.quote),
                          subtitle: Text(eachQuote.author),
                        ),
                      );
                    });
              }

              return Container();
            }));
  }
}

///mData!=null ? ListView.builder(
//         itemCount: mData!["quotes"].length,
//           itemBuilder: (_, index){
//           return Card(
//             child: ListTile(
//               title: Text(mData!["quotes"][index]["quote"]),
//               subtitle: Text(mData!["quotes"][index]["author"]),
//             ),
//           );
//       }) : Center(child: Text("No Quotes!!"),),
