import 'package:flutter/material.dart';

import '/utilities/firebase_file.dart';
import '/utilities/firebase_storage_get_files.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;

  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isImage =
        ['.jpeg', '.jpg', '.png', 'heic', 'HEIC'].any(file.name.contains);

    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
             color: Color.fromARGB(255, 85, 66, 141),),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () async {
              await FirebaseApi.downloadFile(file.ref);

              final snackBar = SnackBar(
                content: Text('Downloaded ${file.name}'),
              );
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            color: Color.fromARGB(255, 238, 237, 243),
            ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isImage
                ? Image.network(
                    file.url,
                    //height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: Text(
                      'Cannot be displayed',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
