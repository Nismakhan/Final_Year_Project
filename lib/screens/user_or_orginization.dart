// import 'package:final_year_project/widgets/common/stack_circles.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:final_year_project/utils/media_query.dart';

// class DoctorPatientScreen extends StatefulWidget {
//   const DoctorPatientScreen({super.key});

//   @override
//   State<DoctorPatientScreen> createState() => _DoctorPatientScreenState();
// }

// class _DoctorPatientScreenState extends State<DoctorPatientScreen> {
//   bool ispatient = false;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             kIsWeb
//                 ? Positioned(
//                     right: 0,
//                     child: CircleAvatar(
//                       backgroundColor: const Color.fromARGB(255, 184, 181, 218),
//                       radius: 80,
//                       child: Image.asset("assets/images/small logo.png"),
//                     ),
//                   )
//                 : const SizedBox(),
//             kIsWeb
//                 ? Positioned(
//                     bottom: 0,
//                     right: -100,
//                     child: StackCirlcles(
//                       width: screenWidth(context) * 0.30,
//                       height: screenHeight(context) * 0.30,
//                     ),
//                   )
//                 : const SizedBox(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//               child: SingleChildScrollView(
//                 child: SizedBox(
//                   height: screenHeight(context),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Row(
//                         children: const [
//                           BackElevatedButton(),
//                         ],
//                       ),
//                       SizedBox(
//                         width: screenwidth(context) * 0.35,
//                         //height: 100,
//                         child: Image.asset("assets/images/doctor patient.png"),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 60),
//                         child: Column(
//                           children: [
//                             const Text(
//                               "ARE YOU A",
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(
//                               height: screenheight(context) * 0.04,
//                             ),
//                             ElevatedButtons(
//                               onPres: () {
//                                 setState(() {
//                                   ispatient = true;
//                                   print(ispatient);
//                                 });
//                                 Navigator.of(context).pushNamed(AppRouter.login,
//                                     arguments:
//                                         ispatient ? "Patient" : "Doctor");
//                               },
//                               text: 'PATIENT',
//                             ),
//                             SizedBox(
//                               height: screenheight(context) * 0.04,
//                             ),
//                             const Text(
//                               "OR",
//                               style: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(
//                               height: screenheight(context) * 0.04,
//                             ),
//                             ElevatedButtons(
//                               onPres: () {
//                                 setState(() {
//                                   ispatient = false;
//                                 });
//                                 Navigator.of(context).pushNamed(AppRouter.login,
//                                     arguments:
//                                         ispatient ? "Patient" : "Doctor");
//                               },
//                               text: 'DOCTOR',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
