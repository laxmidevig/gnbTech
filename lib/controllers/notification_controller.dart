// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:productapp/views/property_detailPage.dart';
// import 'package:productapp/models/property.dart';
//
// class NotificationController extends GetxController {
//   @override
//   void onInit() {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       final propertyId = message.data['propertyId'];
//
//       if (propertyId != null) {
//         // Simulate fetching a property (you should replace with real lookup logic)
//         final property = Property(id: propertyId, title: 'Fetched Property #$propertyId');
//
//         // Navigate using Get.arguments
//         Get.to(() => PropertyDetailView(), arguments: property);
//       }
//     });
//
//     super.onInit();
//   }
// }
