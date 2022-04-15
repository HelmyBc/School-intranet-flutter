
import 'package:enetcom_app/views/root_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ENETCom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: const Color(0xFFF3F5F7),
      ),
      home: const RootApp(),
    );
  }
}

// import 'package:enetcom_app/api_call.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Future<List<Student>> students;

//   @override
//   void initState() {
//     super.initState();
//     students = getStudents();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         title: const Text('Api Calls in Flutter'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: FutureBuilder<List<Student>>(
//             future: students,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(snapshot.data![index].name),
//                         subtitle: Text(snapshot.data![index].email),
//                         trailing: Text(snapshot.data![index].imageUrl),
//                       );
//                     });
//               } else if (snapshot.hasError) {
//                 return Text(snapshot.error.toString());
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             }),
//       ),
//     ));
//   }
// }
