import 'dart:convert';

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
    getQuotes();
  }

  getQuotes() async{
    String url = "https://dummyjson.com/quotes";
    
    var res = await http.get(Uri.parse(url));

    dynamic data = jsonDecode(res.body);

    print(data);
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
      ),
    );
  }
}
