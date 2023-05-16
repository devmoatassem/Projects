import 'package:aeye/screens/image_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aeye/utilities/firebase_file.dart';
import 'package:aeye/utilities/firebase_storage_get_files.dart';


class ShowPictures extends StatefulWidget {
  const ShowPictures({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShowPicturesState createState() => _ShowPicturesState();
}

class _ShowPicturesState extends State<ShowPictures> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('/');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
        
        title: const Text("SOS Pictures"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFF600),
                Color(0xFFFFCF07),
                Color(0xFFFFA80F),
                Color(0xFFFE8116),
              ],
            )
          ),
        ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFF600),
                Color(0xFFFFCF07),
                Color(0xFFFFA80F),
                Color(0xFFFE8116),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
            )
          ),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            
            child: FutureBuilder<List<FirebaseFile>>(
            future: futureFiles,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return const Center(child: Text('Some error occurred!'));
                  } else {
                    final files = snapshot.data!;
        
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildHeader(files.length),
                        const SizedBox(height: 12),
                        Expanded(
                          child: GridView.builder(
                            itemCount: files.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              final file = files[index];
        
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: buildFile(context, file),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
              }
            },
          ),),
        )
        
      );

  Widget buildFile(BuildContext context, FirebaseFile file) => InkWell(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
     
      
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: const Color.fromARGB(255, 34, 54, 70),
        
        leading: const SizedBox(
          width: 52,
          height: 52,
          child: Icon(
            Icons.image_rounded,
            color: Color.fromARGB(255, 228, 61, 0),
          ),
        ),
        title: Text(
          '$length Images',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromARGB(255, 228, 61, 0),
          ),
        ),
      );
}



