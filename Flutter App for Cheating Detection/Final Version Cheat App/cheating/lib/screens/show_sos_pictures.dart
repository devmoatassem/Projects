// import '/screens/image_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '/utilities/firebase_file.dart';
// import '/utilities/firebase_storage_get_files.dart';


// class ShowPictures extends StatefulWidget {
//   const ShowPictures({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ShowPicturesState createState() => _ShowPicturesState();
// }

// class _ShowPicturesState extends State<ShowPictures> {
//   late Future<List<FirebaseFile>> futureFiles;

//   @override
//   void initState() {
//     super.initState();

//     futureFiles = FirebaseApi.listAll('/');
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pop(context),
//           ),
        
//         title: const Text("Cheating Images"),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
            
            
//               color: Color(0xFF9c8cd3),
            
//           ),
//         ),
//         ),
//         body: Container(
//           decoration: const BoxDecoration(
//             //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
//             color: Color.fromARGB(255, 238, 237, 243),
//           ),
//           child: AnnotatedRegion<SystemUiOverlayStyle>(
//             value: SystemUiOverlayStyle.light,
            
//             child: FutureBuilder<List<FirebaseFile>>(
//             future: futureFiles,
//             builder: (context, snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.waiting:
//                   return const Center(child: CircularProgressIndicator());
//                 default:
//                   if (snapshot.hasError) {
//                     return const Center(child: Text('Some error occurred!'));
//                   } else {
//                     final files = snapshot.data!;
        
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // buildHeader(files.length),
//                         const SizedBox(height: 12),
//                         Expanded(
//                           child: GridView.builder(
//                             itemCount: files.length,
//                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
//                             itemBuilder: (context, index) {
//                               final file = files[index];
        
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: buildFile(context, file),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//               }
//             },
//           ),),
//         )
        
//       );

//   Widget buildFile(BuildContext context, FirebaseFile file) => InkWell(
//           child: Image.network(
//             file.url,
//             width: 52,
//             height: 52,
//             fit: BoxFit.cover,
//           ),
     
      
//         onTap: () => Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => ImagePage(file: file),
//         )),
//       );

//   // Widget buildHeader(int length) => ListTile(
//   //       tileColor: const Color.fromARGB(255, 34, 54, 70),
        
//   //       leading: const SizedBox(
//   //         width: 52,
//   //         height: 52,
//   //         child: Icon(
//   //           Icons.image_rounded,
//   //           color: Color(0xFF9c8cd3),
//   //         ),
//   //       ),
//   //       title: Text(
//   //         '$length Images',
//   //         style: const TextStyle(
//   //           fontWeight: FontWeight.bold,
//   //           fontSize: 20,
//   //           color: Color(0xFF9c8cd3),
//   //         ),
//   //       ),
//   //     );
// }


import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '/screens/image_page.dart';
import '/utilities/firebase_file.dart';
import '/utilities/firebase_storage_get_files.dart';

class ShowPictures extends StatefulWidget {
  const ShowPictures({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShowPicturesState createState() => _ShowPicturesState();
}

class _ShowPicturesState extends State<ShowPictures> {
  late Future<List<FirebaseFile>> futureFiles;
  List<FirebaseFile> _files = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('/');
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const duration = Duration(seconds: 30);
    _timer = Timer.periodic(duration, (timer) {
      checkForNewImages();
    });
  }

  Future<void> checkForNewImages() async {
    final files = await FirebaseApi.listAll('/');
    if (files.length != _files.length) {
      setState(() {
        _files = files;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Cheating Images"),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 85, 66, 141),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
    body: Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 238, 237, 243),
      ),
      child: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Some error occurred!'),
            );
          } else {
            _files = snapshot.data!;
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GridView.builder(
                itemCount: _files.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  final file = _files[index];
                  final fileName = file.name.split('/').last;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ImagePage(file: file),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: file.url,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                        key: Key(fileName),
                        cacheKey: fileName,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    ),
  );

  Widget buildFile(BuildContext context, FirebaseFile file) => InkWell(
        child: CachedNetworkImage(
          imageUrl: file.url,
          width: 52,
          height: 52,
          fit: BoxFit.cover,
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )),
      );
}
