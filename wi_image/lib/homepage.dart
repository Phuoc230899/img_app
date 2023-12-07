import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController urlController = TextEditingController();
  final inputString =
      'https://cdn.tgdd.vn/Products/Images/44/313084/hp-15s-fq5229tu-i3-8u237pa-thumb-600x600.png;https://img.tgdd.vn/imgt/f_webp,fit_outside,quality_100/https://cdn.tgdd.vn//News/1499078//laptop-15-800x450-1.jpg';
  Future<void> saveToGallery(String url) async {
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.bodyBytes));
        print(result);
      } else {
        print('Failed to download image');
      }
    } catch (e) {
      print('Error saving image to gallery: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: urlController,
            maxLines: null,
            decoration: const InputDecoration(
              labelText: 'Enter your text',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              List<String> urls = inputString.split(';');
              for (String url in urls) {
                saveToGallery(url);
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text("Send"),
          )
        ],
      ),
    );
  }
}
