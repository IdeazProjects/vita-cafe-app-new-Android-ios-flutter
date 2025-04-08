import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/res/bg.dart';
import 'package:flutter_firebase_notifications/res/pdng.dart';
import 'package:flutter_firebase_notifications/res/txt.dart';
import 'package:flutter_firebase_notifications/view/costraints.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class privacy extends StatefulWidget {
  const privacy({super.key});

  @override
  _privacyState createState() => _privacyState();
}

class _privacyState extends State<privacy> {
  Future<String> fetchAndExtractContent() async {
    final response = await http
        .get(Uri.parse('${Constant.baseUrl_testing}/privacy-policy-app'));

    if (response.statusCode == 200) {
      final document = parse(response.body);
      final textElements = document.querySelectorAll('p');

      String extractedText = '';

      for (var element in textElements) {
        extractedText += element.text + '\n';
      }

      return extractedText;
    } else {
      throw Exception('Failed to load page: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          title: reusabletxt('Privacy & Policy', TextAlign.center, Colors.black,
              FontWeight.bold, 16),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Stack(children: [
          VitalBackgroundImage(),
          FutureBuilder<String>(
            future: fetchAndExtractContent(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator(
                  backgroundColor: Colors.green,
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return reusablepadding(
                    10,
                    0,
                    10,
                    10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusablepadding(
                            10,
                            10,
                            0,
                            0,
                            reusabletxt('Privacy & Policy', TextAlign.start,
                                Colors.black, FontWeight.bold, 27)),
                        Expanded(
                          child: SingleChildScrollView(
                              child: reusabletxt(
                                  snapshot.data.toString(),
                                  TextAlign.justify,
                                  Colors.black,
                                  FontWeight.normal,
                                  16)),
                        ),
                      ],
                    ));
              } else {
                return Center(child: Text('No data available.'));
              }
            },
          )
        ]));
  }
}
