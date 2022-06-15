// import 'package:AAccounting/Screens/admin/Home/home_admin.dart';
// import 'package:AAccounting/Screens/admin/drawer_item.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class NavigationDrawer extends StatelessWidget {
//   const NavigationDrawer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Material(
//         color: Colors.black,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(24, 80, 24, 0),
//           child: Column(
//             children: [
//               headerWidget(),
//               const Divider(thickness: 1, height: 10, color: Colors.grey),
//               DrawerItem(
//                   name: 'Daftar Event',
//                   icon: FontAwesomeIcons.clipboard,
//                   onPressed: ()=> onItemPressed(context, index: 0)
//               ),
//               DrawerItem(
//                   name: 'Laporan',
//                   icon: FontAwesomeIcons.clipboard,
//                   onPressed: ()=> onItemPressed(context, index: 0)
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void onItemPressed(BuildContext context, {required int index}){
//     Navigator.pop(context);

//     switch(index){
//       case 0:
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeAdmin()));
//         break;
//       default:
//         Navigator.pop(context);
//         break;
//     }
//   }

//   Widget headerWidget() {
//     return Row(
//       children: [
//         const CircleAvatar(
//           radius: 40,
//           backgroundImage: AssetImage('assets/images/aulia.JPG'),
//         ),
//         const SizedBox(width: 20),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(24, 80, 24, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text('Admin', style: TextStyle(fontSize: 14, color: Colors.white),),
//               SizedBox(width: 10,),
//               Text('arundaya@gmail.com', style: TextStyle(fontSize: 10, color: Colors.white),)
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
