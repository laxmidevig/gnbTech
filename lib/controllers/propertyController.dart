import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:productapp/bindings/NetworkCheck.dart';
import 'package:productapp/bindings/String.dart';
import 'package:productapp/bindings/toastFunction.dart';
import 'package:productapp/models/property.dart';
import 'package:flutter/material.dart';


class PropertyController extends GetxController {

  List<Property> allProperties = [];
  List<Property> filteredProperties = [];
  List<Property> filteredLogs = [];

  String? postcodeFilter;
  String? machineFilter;
  Map<String, bool> statusFilter = {
    '1': true,  // Active
    '2': true,  // Complete
  };
  int ?page ;
  int ?limit;
  List<dynamic> propertyType = [];

  // final userInfo = GetStorage();
  bool isLoading = false;
  bool isLoadingDate = false;

  Future<void> fetchProperties(dynamic context,int page,int limit) async {
    print('Fetching properties...');
    isLoading = true;
    update(); // Make sure the UI reflects loading state

    String connectionStatus = await checkConnectionStatus();

    if (connectionStatus == '$connected') {
      try {
        final response = await http.post(
          Uri.parse('https://aggregator.dev.gnb.tools/api/job_logs.php'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"page": page, "limit": limit}),
        );

        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        if (jsonResponse['status'] == true) {
          allProperties.clear();
          jsonResponse['response']['logs'].forEach((data) {
            allProperties.add(Property.fromJson(data));
          });

          // Automatically apply default filters after fetch
          await applyFilters();
        } else {
          Get.snackbar(
            "Cannot get Data",
            "${jsonResponse['response']['status']}",
          );
          print('Failed to get Data: ${jsonResponse['response']['status']}');
        }
      } catch (e) {
        print('Error fetching properties: $e');
        Get.snackbar("Error", "An error occurred while fetching data.");
      }
    } else {
      print('Connection failed: $connectionStatus');
      offlineDialogBox(context);
    }

    isLoading = false;
    update();
  }

  Future<void> applyFilters({
    String? postcodeContains,
    String? machineIdEquals,
    Set<String>? statusIn,
  }) async {
    filteredLogs = allProperties.where((log) {
      final matchPostcode = postcodeContains == null || postcodeContains.isEmpty || log.postcode.contains(postcodeContains);
      final matchMachineId = machineIdEquals == null || log.machine_id == machineIdEquals;
      final matchStatus = statusIn == null || statusIn.contains(log.status);
      return matchPostcode && matchMachineId && matchStatus;
    }).toList();
    isLoading = false;
    update(); // Notifies the GetBuilder to rebuild
  }
}
//   Future<void> applyFilters({
//     String postcodeContains = '',
//     String? machineIdEquals,
//     Set<String>? statusIn,
//   }) async {
//     propertyType
//       ..clear()
//       ..addAll(allProperties.where((p) {
//         final byPostcode = postcodeContains.isEmpty ||
//             p.postcode.toLowerCase().contains(postcodeContains.toLowerCase());
//         print("${p.postcode}dw");
//         final byMachine = machineIdEquals == null ||
//             p.machine_id == machineIdEquals;
//         final byStatus = statusIn == null || statusIn.contains(p.status);
//         return byPostcode && byMachine && byStatus;
//       }));
//     update();
//   }
// }
//   Future<void> applyFilters({
//     String postcodeContains = '',
//     String? machineIdEquals,
//     Set<String>? statusIn,
//   }) async {
//     propertyType
//       ..clear()
//       ..addAll(allProperties.where((p) {
//         final byPostcode = postcodeContains.isEmpty ||
//             p.postcode.toLowerCase().contains(postcodeContains.toLowerCase());
//         final byMachine = machineIdEquals == null ||
//             p.machine_id == machineIdEquals;
//         final byStatus = statusIn == null || statusIn.contains(p.status);
//
//         return byPostcode && byMachine && byStatus;
//       }));
//     update();
//   }
// }