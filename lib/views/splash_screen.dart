
// import 'package:enetcom_app/views/login_screen.dart';
// import 'package:enetcom_app/views/root_app_animated.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final TokenService _tokenService = TokenService();
//   final AuthService _authService = AuthService();

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () async {
//       verifyCurrentToken();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('SPLASH: AUTH'),
//       ),
//     );
//   }

//   verifyCurrentToken() async {
//     if (_tokenService.exists()) {
//       bool refresh = await _authService.refreshToken();
//       if (refresh) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) => const RootAppAnimated(),
//           ),
//           (route) => false,
//         );
//       } else {
//         _tokenService.delete();
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) => const LoginScreen(),
//           ),
//           (route) => false,
//         );
//       }
//     } else {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => const LoginScreen(),
//         ),
//         (route) => false,
//       );
//     }
//   }
// }