// import 'package:flutter/material.dart';

// class Notifications extends StatelessWidget {
//   const Notifications({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leadingWidth: 70,
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           elevation: 0,
//           title: const Text("Notifications"),
//         ),
//         body: const Text("Notifications"),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/auth/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app/router/router.dart';

class SearchingUser extends StatefulWidget {
  const SearchingUser({super.key});

  @override
  State<SearchingUser> createState() => _SearchingUserState();
}

class _SearchingUserState extends State<SearchingUser> {
  @override
  Widget build(BuildContext context) {
    String searchText = '';
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("loading..."));
          }

          return ListView(
            scrollDirection: Axis.vertical,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              UserModel doctorData = UserModel.fromJson(data);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        AppRouter.otherUserprofileScreen,
                        arguments: doctorData);
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: doctorData.profileUrl != null
                            ? CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage(doctorData.profileUrl!),
                              )
                            : const CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/user.png"),
                              ),
                        title: Text(doctorData.name,
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )),
                        subtitle: Text(
                          doctorData.email,
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            color: Color.fromARGB(255, 151, 190, 221),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        });
  }
}
class OtherUserProfileArgs {
  String uid;
  OtherUserProfileArgs({required this.uid});
}