// import 'package:enetcom_app/models/classe.dart';
// import 'package:enetcom_app/models/course.dart';
// import 'package:enetcom_app/models/post.dart';
// import 'package:enetcom_app/models/subject.dart';
// import 'package:enetcom_app/models/td.dart';
// import 'package:enetcom_app/models/user.dart';
// import 'package:enetcom_app/services/http_user_service.dart';
// import 'package:get/state_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserController extends GetxController {
//   var isLoading = true.obs;
//   var currentUser = User(email: "", password: "").obs;
//   var currentUserClasse =
//       Classe(depId: 0, groupe: 0, id: 0, level: 0, name: '').obs;
//   var currentClasse = Classe(id: 0, level: 0, groupe: 0, depId: 0, name: "");
//   var currentSubject =
//       Subject(id: 0, classeId: 0, teacherId: 0, name: "", teacherName: "");

//   var currentUserType = "".obs;
//   var currentUserId = 0.obs;
//   var currentClasseId = 0.obs;
//   var currentSubjectId = 0.obs;
//   var currentCourseId = 0.obs;
//   var currentUserTypeInt = 0.obs;
//   var userList = <User>[].obs;
//   var currentUserSubjects = <Subject>[].obs;
//   var currentUserClasses = <Classe>[].obs;
//   var currentUserClasseSubjects = <Subject>[].obs;
//   var currentUserClasseSubjectCourses = <Course>[].obs;
//   var currentUserClasseSubjectTds = <Td>[].obs;
//   var currentUserPosts = <Post>[].obs;

//   @override
//   void onInit() {
//     getCurrentUser();

//     super.onInit();
//     fetchUsers();
//   }

//   void getCurrentUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     currentUserId.value = await prefs.getInt('cuid')!;
//     currentUser.value = await HttpUserService.getUser(prefs.getInt('cuid')!);
//     if (currentUserTypeInt.value == 0) {
//       currentClasse =
//           await HttpUserService.fetchUserClasse(currentUser.value.id!);
//     }
//     if (currentUserTypeInt.value == 1) {
//       currentUserClasses.value =
//           await HttpUserService.fetchUserClasses(currentUser.value.id!);
//     }
//   }

//   void getCurrentUserType() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var isTeacher = prefs.getBool('isTeacher') ?? false;
//     var isStudent = prefs.getBool('isStudent') ?? false;
//     if (isStudent) {
//       currentUserTypeInt.value = 0;
//     } else if (isTeacher) {
//       currentUserTypeInt.value = 1;
//     } else {
//       currentUserTypeInt.value = 0;
//     }
//   }

//   void getCurrentUserPosts() async {
//     currentUserPosts.value =
//         await HttpUserService.fetchUserPosts(currentUser.value.id!);
//   }

//   //for classroom student screen
//   void getCurrentUserClasse() async {
//     if (currentUserTypeInt.value == 0) {
//       currentClasse =
//           await HttpUserService.fetchUserClasse(currentUser.value.id!);
//     }
//   }

//   //For classroom student screen
//   void getUserSubjects() async {
//     getCurrentUser();
//     getCurrentUserClasse();
//     currentUserSubjects.value =
//         await HttpUserService.fetchUserSubjects(currentUser.value.id!);
//   }

// //for classroom teacher screen
//   void getCurrentUserClasses() async {
//     if (currentUserTypeInt.value == 1) {
//       currentUserClasses.value =
//           await HttpUserService.fetchUserClasses(currentUser.value.id!);
//     }
//   }

// //for classroom teacher second screen
//   void getUserClasseSubjects() async {
//     currentUserClasseSubjects.value =
//         await HttpUserService.fetchUserClasseSubjects(
//       currentUser.value.id!,
//       currentClasseId.value,
//     );
//   }

// //for classroom teacher third screen
//   void getUserClasseSubjectCourses() async {
//     currentUserClasseSubjectCourses.value =
//         await HttpUserService.fetchSubjectCourses(currentSubjectId.value);
//   }

// //for classroom teacher third screen
//   void getUserClasseSubjectTds() async {
//     currentUserClasseSubjectTds.value =
//         await HttpUserService.fetchSubjectTds(currentSubjectId.value);
//   }

//   void fetchUsers() async {
//     try {
//       isLoading(true);
//       var users = await HttpUserService.fetchUsers();
//       if (users != null) {
//         userList.value = users;
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }
import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/models/course.dart';
import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/models/td.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:enetcom_app/services/http_user_service.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var currentUser = User(email: "", password: "").obs;
  var currentUserClasse =
      Classe(depId: 0, groupe: 0, id: 0, level: 0, name: '').obs;
  var currentClasse = Classe(id: 0, level: 0, groupe: 0, depId: 0, name: "");
  var currentSubject =
      Subject(id: 0, classeId: 0, teacherId: 0, name: "", teacherName: "");
  var currentUserType = "".obs;
  var currentUserId = 0.obs;
  var currentClasseId = 0.obs;
  var currentSubjectId = 0.obs;
  var currentCourseId = 0.obs;
  var currentUserTypeInt = 0.obs;
  var userList = <User>[].obs;
  var currentUserSubjects = <Subject>[].obs;
  var currentUserClasses = <Classe>[].obs;
  var currentUserClasseSubjects = <Subject>[].obs;
  var currentUserClasseSubjectCourses = <Course>[].obs;
  var currentUserClasseSubjectTds = <Td>[].obs;
  var currentUserPosts = <Post>[].obs;
  var selectedUserPosts = <Post>[].obs;

  @override
  void onInit() {
    fetchUsers();
    //loadCurrentUser();
    getCurrentUser();
    // getCurrentUserSubjects();
    getCurrentUserClasses();
    // getUserClasseSubjects();
    // getUserClasseSubjectCourses();
    super.onInit();
  }

  void getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // newly added
    currentUserId.value = prefs.getInt('cuid')!;
    currentUser.value = await HttpUserService.getUser(prefs.getInt('cuid')!);
  }

  void getCurrentUserPosts() async {
    currentUserPosts.value =
        await HttpUserService.fetchUserPosts(currentUser.value.id!);
  }

  //FOR USERS PROFILES
  void getSelectedUserPosts(User user) async {
    selectedUserPosts.clear();
    selectedUserPosts.value = await HttpUserService.fetchUserPosts(user.id!);
  }

  //For classroom student screen
  void getCurrentUserSubjects() async {
    currentUserSubjects.value =
        await HttpUserService.fetchUserSubjects(currentUser.value.id!);
  }

//for classroom teacher screen
  void getCurrentUserClasses() async {
    currentUserClasses.value =
        await HttpUserService.fetchUserClasses(currentUser.value.id!);
  }

//for classroom teacher second screen
  void getUserClasseSubjects() async {
    currentUserClasseSubjects.value =
        await HttpUserService.fetchUserClasseSubjects(
      currentUser.value.id!,
      currentClasseId.value,
    );
  }

//for classroom teacher third screen
  void getUserClasseSubjectCourses() async {
    currentUserClasseSubjectCourses.value =
        await HttpUserService.fetchSubjectCourses(currentSubjectId.value);
  }

//for classroom teacher third screen
  void getUserClasseSubjectTds() async {
    currentUserClasseSubjectTds.value =
        await HttpUserService.fetchSubjectTds(currentSubjectId.value);
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      var users = await HttpUserService.fetchUsers();
      if (users != null) {
        userList.value = users;
      }
    } finally {
      isLoading(false);
    }
  }

  // void loadCurrentUser() async {
  //   try {
  //     isLoading(true);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var cuid = prefs.getInt('cuid');
  //     if (cuid != null) {
  //       User currentUser = await HttpUserService.getUser(cuid);
  //       currentUserId.value = cuid;
  //     } else {
  //       cuid = 0;
  //       prefs.setInt('cuid', 0);
  //       currentUserId.value = 0;
  //     }
  //   } catch (Excepetion) {
  //     print(
  //         "An error while loading current user from shared pref has occured: $Excepetion");
  //     isLoading(false);
  //   }
  // }
}

// import 'package:enetcom_app/models/classe.dart';
// import 'package:enetcom_app/models/course.dart';
// import 'package:enetcom_app/models/post.dart';
// import 'package:enetcom_app/models/subject.dart';
// import 'package:enetcom_app/models/td.dart';
// import 'package:enetcom_app/models/user.dart';
// import 'package:enetcom_app/services/http_user_service.dart';
// import 'package:get/state_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserController extends GetxController {
//   var isLoading = true.obs;
//   var currentUser = User(email: "", password: "").obs;
//   var currentUserClasse =
//       Classe(depId: 0, groupe: 0, id: 0, level: 0, name: '').obs;
//   var currentClasse = Classe(id: 0, level: 0, groupe: 0, depId: 0, name: "");
//   var currentSubject =
//       Subject(id: 0, classeId: 0, teacherId: 0, name: "", teacherName: "");

//   var currentUserType = "".obs;
//   var currentUserId = 0.obs;
//   var currentClasseId = 0.obs;
//   var currentSubjectId = 0.obs;
//   var currentCourseId = 0.obs;
//   var currentUserTypeInt = 0.obs;
//   var userList = <User>[].obs;
//   var currentUserSubjects = <Subject>[].obs;
//   var currentUserClasses = <Classe>[].obs;
//   var currentUserClasseSubjects = <Subject>[].obs;
//   var currentUserClasseSubjectCourses = <Course>[].obs;
//   var currentUserClasseSubjectTds = <Td>[].obs;
//   var currentUserPosts = <Post>[].obs;

//   @override
//   void onInit() {
//     getCurrentUser();
//     super.onInit();
//     fetchUsers();
//   }

//   void getCurrentUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     currentUserId.value = await prefs.getInt('cuid')!;
//     currentUser.value = await HttpUserService.getUser(prefs.getInt('cuid')!);
//     if (currentUserTypeInt.value == 0) {
//       currentClasse =
//           await HttpUserService.fetchUserClasse(currentUser.value.id!);
//     }
//     if (currentUserTypeInt.value == 1) {
//       currentUserClasses.value =
//           await HttpUserService.fetchUserClasses(currentUser.value.id!);
//     }
//   }

//   void getCurrentUserType() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var isTeacher = prefs.getBool('isTeacher') ?? false;
//     var isStudent = prefs.getBool('isStudent') ?? false;
//     if (isStudent) {
//       currentUserTypeInt.value = 0;
//     } else if (isTeacher) {
//       currentUserTypeInt.value = 1;
//     } else {
//       currentUserTypeInt.value = 0;
//     }
//   }

//   void getCurrentUserPosts() async {
//     currentUserPosts.value =
//         await HttpUserService.fetchUserPosts(currentUser.value.id!);
//   }

//   //for classroom student screen
//   void getCurrentUserClasse() async {
//     if (currentUserTypeInt.value == 0) {
//       currentClasse =
//           await HttpUserService.fetchUserClasse(currentUser.value.id!);
//     }
//   }

//   //For classroom student screen
//   void getUserSubjects() async {
//     // getCurrentUser();
//     // getCurrentUserClasse();
//     currentUserSubjects.value =
//         await HttpUserService.fetchUserSubjects(currentUser.value.id!);
//   }

// //for classroom teacher screen
//   void getCurrentUserClasses() async {
//     if (currentUserTypeInt.value == 1) {
//       currentUserClasses.value =
//           await HttpUserService.fetchUserClasses(currentUser.value.id!);
//     }
//   }

// //for classroom teacher second screen
//   void getUserClasseSubjects() async {
//     currentUserClasseSubjects.value =
//         await HttpUserService.fetchUserClasseSubjects(
//       currentUser.value.id!,
//       currentClasseId.value,
//     );
//   }

// //for classroom teacher third screen
//   void getUserClasseSubjectCourses() async {
//     currentUserClasseSubjectCourses.value =
//         await HttpUserService.fetchSubjectCourses(currentSubjectId.value);
//   }

// //for classroom teacher third screen
//   void getUserClasseSubjectTds() async {
//     currentUserClasseSubjectTds.value =
//         await HttpUserService.fetchSubjectTds(currentSubjectId.value);
//   }

//   void fetchUsers() async {
//     try {
//       isLoading(true);
//       var users = await HttpUserService.fetchUsers();
//       if (users != null) {
//         userList.value = users;
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }
