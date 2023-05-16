// import 'package:flutter/material.dart';

// import 'package:aeye/utilities/firebase_file.dart';
// import 'package:aeye/utilities/firebase_storage_get_files.dart';

// class ImagePage extends StatelessWidget {
//   final FirebaseFile file;

//   const ImagePage({
//     Key? key,
//     required this.file,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isImage =
//         ['.jpeg', '.jpg', '.png', 'heic', 'HEIC'].any(file.name.contains);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(file.name),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(
//             colors: [
//               Color(0xFF3594DD),
//               Color(0xFF4563DB),
//               Color(0xFF5036D5),
//               Color(0xFF5B16D0),
//             ],
//           )),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.file_download),
//             onPressed: () async {
//               await FirebaseApi.downloadFile(file.ref);

//               final snackBar = SnackBar(
//                 content: Text('Downloaded ${file.name}'),
//               );
//               // ignore: use_build_context_synchronously
//               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//             },
//           ),
//           const SizedBox(width: 12),
//         ],
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//             //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
//             gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Color(0xFFFFF600),
//                 Color(0xFFFFCF07),
//                 Color(0xFFFFA80F),
//                 Color(0xFFFE8116),
//           ],
//           stops: [0.1, 0.4, 0.7, 0.9],
//         )),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: isImage
//                 ? Image.network(
//                     file.url,
//                     //height: double.infinity,
//                     fit: BoxFit.cover,
//                   )
//                 : const Center(
//                     child: Text(
//                       'Cannot be displayed',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
