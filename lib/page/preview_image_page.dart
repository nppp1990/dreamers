import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PreviewImagePage extends StatefulWidget {
  final String? imageUrl;
  final File? imageFile;

  const PreviewImagePage({super.key, this.imageUrl, this.imageFile});

  @override
  State<StatefulWidget> createState() => _PreviewImagePageState();
}

class _PreviewImagePageState extends State<PreviewImagePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }

  String? get imageUrl => widget.imageUrl;

  File? get imageFile => widget.imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Center(
                child: imageFile == null
                    ? Image.network(imageUrl!, width: double.infinity, fit: BoxFit.contain)
                    : Image.file(imageFile!, width: double.infinity, fit: BoxFit.contain),
              ),
            ),
            Positioned(
              right: 40,
              bottom: 60,
              child: GestureDetector(
                onTap: _saveImage,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5B5B5B),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.save_alt_outlined,
                    color: Color(0xFFF9F9F9),
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  _saveImage() async {
    // todo
    // final image = imageFile == null ? NetworkImage(imageUrl!) : FileImage(imageFile!);
    // final bytes = await image.obtainKey(const ImageConfiguration()).obtainCache();
    // final directory = await getApplicationDocumentsDirectory();
    // final path = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    // final file = File(path);
    // await file.writeAsBytes(bytes);
  }
}
