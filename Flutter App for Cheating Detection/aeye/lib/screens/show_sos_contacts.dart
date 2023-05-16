import 'package:aeye/utilities/add_contacts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aeye/utilities/firebase_file.dart';
import 'package:aeye/utilities/firebase_storage_get_files.dart';

import '../utilities/constants.dart';

class ShowContacts extends StatefulWidget {
  ShowContacts({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShowContactsState createState() => _ShowContactsState();
}

class _ShowContactsState extends State<ShowContacts> {
  Query dbRef = FirebaseDatabase.instance.ref().child(Currentuid);
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child(Currentuid);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    //deleteContact();
  }

  void deleteContact() async {
    // final event = await dbRef.once(DatabaseEventType.value);
    // final username = event.snapshot.value;
    // print(username);
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child(Currentuid).get();
    Map SOSContact = snapshot.value as Map;
    SOSContact['key'] = snapshot.key;
    if (snapshot.exists) {
      print(snapshot.value!);
    } else {
      print('No data available.');
    }
  }

  Widget listItem({required Map SOSContact}) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      //padding: const EdgeInsets.only(left: 20, right: 5),
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color

        borderRadius: BorderRadius.circular(10), // Set the border radius
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 49, 48, 48)
                .withOpacity(0.5), // Set the shadow color
            spreadRadius: 2, // Set the spread radius of the shadow
            blurRadius: 5, // Set the blur radius of the shadow
            offset: const Offset(0, 3), // Set the offset of the shadow
          ),
        ],
      ),
      //height: 110,
      //color: Colors.white,
      child: ListTile(
        title: Text(
          SOSContact['name'],
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        subtitle: Text(
          SOSContact['contact'],
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            letterSpacing: 1.5,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          iconSize: 40,
          onPressed: () {
            reference.child(SOSContact['key']).remove();

            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) =>
            //         MyMap(snapshot.data!.docs[index].id)));
          },
        ),
      ),

    );
  }

  Widget _buildAddContactBtn() {
    return Container(
      padding: const EdgeInsets.all(25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) {
            return const AddContacts();
          })));
        },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text(
          'Add',
          style: TextStyle(
            color: Color.fromARGB(255, 228, 61, 0),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold (
        appBar: AppBar(
          title: const Text("SOS Contacts"),
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
            )),
          ),
        ),
        body: Container(
          height: double.infinity,
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
          )),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Column(
              children: [
                Expanded(
                  child: FirebaseAnimatedList(
                    query: dbRef,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map SOSContact = snapshot.value as Map;
                      SOSContact['key'] = snapshot.key;

                      return listItem(SOSContact: SOSContact);
                    },
                  ),
                ),
                _buildAddContactBtn()
              ],
            ),
          ),
        ),
      );
}


