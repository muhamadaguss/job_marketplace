// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:beeattt/injection_container.dart' as di;
// import '../injection_container.dart';
// import '../model/notification_model.dart';
// import '../pages/custom_notification_details.dart';
// import '../pages/notification_page.dart';
// import '../routes/app_pages.dart';
// import '../utils/notification_dialog.dart';

// class NotificationService {


//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   final String subscriptionTopic = 'all';


//   Future _handleIosNotificationPermissaion () async {
//     NotificationSettings settings = await _fcm.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         debugPrint('User granted permission');
//       } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//         debugPrint('User granted provisional permission');
//       } else {
//         debugPrint('User declined or has not accepted permission');
//       }
//   }





//   Future initFirebasePushNotification(context) async {
//     if (Platform.isIOS) {
//       _handleIosNotificationPermissaion();
//     }
//     String? _token = await _fcm.getToken();
//     print('User FCM Token : $_token');

//     RemoteMessage? initialMessage = await _fcm.getInitialMessage();
//     debugPrint('inittal message : $initialMessage');
//     if (initialMessage != null) {
//       await saveNotificationData(initialMessage).then((value) => _navigateToDetailsScreen(context, initialMessage));

      
//     }
    

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       debugPrint('onMessage: ${message.notification!.body}');
//       // await saveNotificationData(message).then((value) => _handleOpenNotificationDialog(context, message));
//       await saveNotificationData(message).then((value) => _navigateToDetailsScreen(context, message));
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       await saveNotificationData(message).then((value) => _navigateToDetailsScreen(context, message));
//     });
//   }



//   Future _handleOpenNotificationDialog(context, RemoteMessage message) async {
//     DateTime now = DateTime.now();
//     String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
//     NotificationModel notificationModel = NotificationModel(
//         timestamp: _timestamp,
//         date: message.sentTime,
//         title: message.notification!.title,
//         body: message.notification!.body,
//         postID: message.data['post_id'] == null ? null : int.parse(message.data['post_id']),
//         thumbnailUrl: message.data['image']
//     );
//      Navigator.of(di.sl<GlobalKey<NavigatorState>>().currentContext??context).push(PageRouteBuilder(pageBuilder: (_,__,___)=> new CustomNotificationDeatils(notificationModel: notificationModel,)));
//   }


//   Future _navigateToDetailsScreen(context, RemoteMessage message) async {
//     DateTime now = DateTime.now();
//     String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
//     NotificationModel notificationModel = NotificationModel(
//         timestamp: _timestamp,
//         date: message.sentTime,
//         title: message.notification!.title,
//         body: message.notification!.body,     
//         id: message.data['id'],
//         type: message.data['type'],
//         permissionName: message.data['permission_name'],
//         status: message.data['status'],
//         reason: message.data['reason'],
//         masterEmployeeId: message.data['master_employee_id'],
//         employee_name: message.data['employee_name'],        
//         masterLeaveId: message.data['master_leave_id'],
//         leaveName: message.data['leave_name'],
//         npk: message.data['npk'],
//         spvId: message.data['spv_id'],
//         detailLeaveId: message.data['detail_leave_id'],
//         submitDate: message.data['submit_date'],
//         leaveDate: message.data['leave_date'],
//         leaveStatus: message.data['leave_status'],
//         numbOfLeave: message.data['numb_of_leave'],
//         pic: message.data['pic'],
//         picName: message.data['pic_name'],
//         masterPersonId: message.data['master_person_id'],
//         masterCompanyId: message.data['master_company_id'],
//         createdAt: message.data['created_at'],
//         createdBy: message.data['created_by'],
//         image: message.data['image'],

//         // 'name': message.data['name'],
//         // 'endDate': message.data['end_date'],
//         // 'address': message.data['address'],
//         // 'comment': message.data['comment'],
//         // 'departments': message.data['departments'],
//         // 'priode': message.data['priode'],
//     );
//       if(sl<SharedPreferences>().getBool('is_supervisor') ??false)  Navigator.of(di.sl<GlobalKey<NavigatorState>>().currentContext??context).push(PageRouteBuilder(pageBuilder: (_,__,t___)=> new CustomNotificationDeatils(notificationModel: notificationModel,)));
//             //  if(sl<SharedPreferences>().getBool('is_supervisor') ?? false)Navigator.pushNamed(di.sl<GlobalKey<NavigatorState>>().currentContext??context, Routes.approval);
//                 // if(sl<SharedPreferences>().getBool('is_supervisor') ?? true)Navigator.pushNamed(di.sl<GlobalKey<NavigatorState>>().currentContext??context, Routes.riwayatPengajuan);
//     //  navigateToNotificationDetailsScreen(context, notificationModel);
//   }



//   Future saveNotificationData(RemoteMessage message) async {
//     final list = Hive.box('notifications');
//     DateTime now = DateTime.now();
//     String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
//     Map<String, dynamic> _notificationData = {


//           //Cuti
//           //  'id' => $emp_leave->id,
//           //       'type' => 'cuti',
//           //       'status' => 'sukses',
//           //       'reason' => $request->reason,
//           //       'master_employee_id' => $employee->id,
//           //       'employee_name' => MasterPerson::where('id',$employee->master_person_id)->first()->name,
//           //       'master_leave_id' => $request->master_leave_id,
//           //       'leave_name' => MasterLeave::where('id',$request->master_leave_id)->first()->name,
//           //       'npk' => $employee->npk,
//           //       'spv_id' => $employee->spv_id,
//           //       'detail_leave_id' => $sisa->id ?? null,
//           //       'submit_date' => date("Y-m-d"),
//           //       'leave_date' => $request->leave_date,
//           //       'leave_status' => "new",
//           //       'numb_of_leave' => $request->numb_of_leave,
//           //       'pic' => $request->pic,
//           //       'pic_name' =>
//           //                'end_date' => $skipweek,
 


// //           ijin

// //             $data = [
// //                 'id' => DB::getPdo()->lastInsertId(),
// //                 'type' => 'ijin',
// //                 'status' => 'sukses',
// //                 'master_employee_id' => $employee->id,
// //                 'master_permission_id' => $request->permissionId,
// //                 'reason' => $request->reason,
// //                 'master_company_id' => $user->master_company_id,
// //                 'leave_date' => $request->leave_date,
// //                 'created_at' => 'now()',
// //                 'status' => $status,
// //                 'spv_id' => $employee->spv_id,
// //                 'created_by' => $user->id,
// //             ];


//   //         sakit 
//   //               $data = [
//   //                   'id' => DB::getPdo()->lastInsertId(),
//   //                   'type' => 'sakit',
//   //                   'status' => 'sukses',
//   //                   'master_employee_id' => $employee->id,
//   //                   'master_permission_id' => $request->permissionId,
//   //                   'reason' => $request->reason,
//   //                   'master_company_id' => $user->master_company_id,
//   //                   'leave_date' => $request->date,
//   //                   'created_at' => 'now()',
//   //                   'status' => $status,
//   //                   'spv_id' => $employee->spv_id,
//   //                   'created_by' => $user->id,
//   //                   'image' => $image ?? null
//   //               ];
      



//       'timestamp': _timestamp,
//       'date': message.sentTime,
//       'title': message.notification!.title,
//       'body': message.notification!.body,
//         'id': message.data['id'],
//         'type': message.data['type'],
//         'status': message.data['status'],
//         'reason': message.data['reason'],
//         'masterEmployeeId': message.data['master_employee_id'],
//         'employee_name': message.data['employee_name'],        
//         'masterLeaveId': message.data['master_leave_id'],
//         'leaveName': message.data['leave_name'],
//         'npk': message.data['npk'],
//         'spvId': message.data['spv_id'],
//         'detailLeaveId': message.data['detail_leave_id'],
//         'submitDate': message.data['submit_date'],
//         'leaveDate': message.data['leave_date'],
//         'leaveStatus': message.data['leave_status'],
//         'numbOfLeave': message.data['numb_of_leave'],
//         'permission_name': message.data['permission_name'],
//         'pic': message.data['pic'],
//         'picName': message.data['pic_name'],
//         'masterPersonId': message.data['master_person_id'],
//         'masterCompanyId': message.data['master_company_id'],
//         'createdAt': message.data['created_at'],
//         'createdBy': message.data['created_by'],
//       'image': message.data['image'],

//         // 'name': message.data['name'],
//         // 'endDate': message.data['end_date'],
//         // 'address': message.data['address'],
//         // 'comment': message.data['comment'],
//         // 'departments': message.data['departments'],
//         // 'priode': message.data['priode'],
//     };

//     await list.put(_timestamp, _notificationData);
//   }



//   Future deleteNotificationData(key) async {
//     final bookmarkedList = Hive.box('notifications');
//     await bookmarkedList.delete(key);
//   }



//   Future deleteAllNotificationData() async {
//     final bookmarkedList = Hive.box('notifications');
//     await bookmarkedList.clear();
//   }

  

//   Future<bool> handleFcmSubscribtion() async {
//     final SharedPreferences sp = await SharedPreferences.getInstance();
//     bool _subscription = sp.getBool('subscribed') ?? true;
//     if (_subscription == true) {
//       _fcm.subscribeToTopic(subscriptionTopic);
//       debugPrint('subscribed');
//     } else {
//       _fcm.unsubscribeFromTopic(subscriptionTopic);
//       debugPrint('unsubscribed');
//     }

//     return _subscription;
//   }
// }
