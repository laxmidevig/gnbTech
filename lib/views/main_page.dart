import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productapp/controllers/propertyController.dart';
import '../routes/app_pages.dart';

class MainPage extends StatefulWidget {


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PropertyController controller = Get.put(PropertyController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool applyFilter=false;
  final ImagePicker _picker = ImagePicker(); // now refers to package
  XFile? _image;

  @override
  void initState() {
    super.initState();

   // controller.fetchProperties(context);
  }
  Widget build(BuildContext context) {
    double s = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            "Product List",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: s * 0.055,
                color: Colors.white),
          ),
        leading: IconButton(               // 2️⃣ Your custom drawer button
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
         //  drawer: _buildFilterDrawer();
           _scaffoldKey.currentState?.openDrawer();
           },
        ),
          ),
      drawer: _buildFilterDrawer(),
      body: GetBuilder<PropertyController>(
          init: PropertyController(),
          builder: (controller) {
            return    Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: TextButton(onPressed: (){
                       // getImage();
                        Get.toNamed('/imagePic');
                        }, child: Text('PickImage',style: TextStyle(fontSize: s*0.035,color: Colors.blueAccent,fontWeight: FontWeight.bold),)),
                    )),
            _image == null
            ? const Text('No image selected.')
                : Image.file(File(_image!.path)),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 120,
                        child: Row(
                          children: [
                            Text('Page :', style: TextStyle(fontSize: s * .045, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 20,),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (val) async {
                                  controller.page = int.tryParse(val) ?? 1;
                                  print('pagedd${controller.page}');
                                  final safePage = controller.page ?? 1; // fallback if null
                                  final safeLimit = controller.limit ?? 100;

                                  await controller.fetchProperties(context, safePage, safeLimit);
                                },
                                decoration: const InputDecoration(hintText: 'e.g. 1'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30,),
                      SizedBox(
                        height: 60,
                        width: 120,
                        child: Row(
                          children: [
                            Text('Limit :', style: TextStyle(fontSize: s * .045, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 20,),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (val) async{
                                  controller.limit = int.tryParse(val) ?? 100;
                                  print('limit${controller.limit}');
                                  controller.limit = int.tryParse(val) ?? 100;
                                  print('limit ${controller.limit}');

                                  final safePage = controller.page ?? 1; // fallback if null
                                  final safeLimit = controller.limit ?? 100;

                                  await controller.fetchProperties(context, safePage, safeLimit);
                                },
                                decoration: const InputDecoration(hintText: 'e.g. 100'),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 10),


                if (controller.isLoading == true)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: s * 0.10),
                      CircularProgressIndicator(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        strokeWidth: 2,
                      ),
                    ],
                  ),
                const SizedBox(height: 10,),
              if( controller.allProperties.isNotEmpty)

                Expanded(

                  child: ListView.builder(
                    itemCount: controller.filteredLogs.length,
                    itemBuilder: (item, index) {
                      final prop = controller.filteredLogs[index];
                      //final property = controller.propertyType[index];
                      return GestureDetector(
                        onTap: ()async {
                          // await  FirebaseAnalytics.instance.logEvent(
                          //   name: 'test_event',
                          //   parameters: {'button': 'clicked'},
                          // );
                        await  FirebaseAnalytics.instance.logEvent(
                            name: 'product_MainPage',
                            parameters: {
                              'product_id': controller.filteredLogs[index].id
                              .toString().isNotEmpty ? "ID :${controller.filteredLogs[index].id
                              .toString()}":"ID-100",
                              'product_name': controller.filteredLogs[index].postcode
                                  .toString().isNotEmpty ? "PostCode :${controller.filteredLogs[index].postcode
                                  .toString()}":"G-68",
                            },
                          );

                        },
                        //onTap: () => Get.toNamed(AppRoutes.propertyDetailPage,),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.filteredLogs[index].id
                                      .toString().isNotEmpty ? "ID :${controller.filteredLogs[index].id
                                      .toString()}":"",
                                    style:  TextStyle(
                                        fontSize: s*.045, fontWeight: FontWeight.bold),),
                                  Text(controller.filteredLogs[index].machine_id
                                      .toString().isNotEmpty ? "Machine ID :${controller.filteredLogs[index].machine_id
                                      .toString()}":"", style:  TextStyle(
                                      fontSize:s*.045,fontWeight: FontWeight.w400),),
                                  Text(
                                    controller.filteredLogs[index].postcode
                                        .toString().isNotEmpty ? "PostCode :${controller.filteredLogs[index].postcode
                                        .toString()}":"",
                                    style:  TextStyle(
                                        fontSize: s*.045, fontWeight: FontWeight.w400),),
                                ],
                              ),
                            ),

                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
           }
    ),
    );
  }
  Widget _buildFilterDrawer() {
    double s = MediaQuery.of(context).size.width;
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GetBuilder<PropertyController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Filters',
                    style: TextStyle(fontSize: s*.045, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Postcode filter
                   Text('Postcode contains:',style: TextStyle(fontSize: s*.045, fontWeight: FontWeight.normal)),
                  TextField(
                    onChanged: (value) {
                      controller.postcodeFilter = value;
                    },
                    decoration: const InputDecoration(hintText: 'e.g. G68'),
                  ),
                  const SizedBox(height: 16),

                  // Machine ID dropdown
                  Text('Machine ID:',style: TextStyle(fontSize: s*.045, fontWeight: FontWeight.normal)),
                  DropdownButton<String>(
                    hint: const Text('Any'),
                    value: controller.machineFilter,
                    isExpanded: true,
                    items: [
                      null,
                      ...{for (var p in controller.allProperties) p.machine_id}.toSet()
                    ].map((m) {
                      return DropdownMenuItem<String>(
                        value: m,
                        child: Text(m ?? 'All',style: TextStyle(fontSize: s*.045, fontWeight: FontWeight.normal)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.machineFilter = value;
                      controller.update();
                    },
                  ),
                  const SizedBox(height: 16),

                  // Status checkboxes
                   Text('Status:',style: TextStyle(fontSize: s*.045, fontWeight: FontWeight.normal)),
                  ...controller.statusFilter.keys.map((key) {
                    return CheckboxListTile(
                      title: Text(key == '1' ? 'Active' : 'Complete',style: TextStyle(fontSize: s*.045, fontWeight: FontWeight.normal)),
                      value: controller.statusFilter[key],
                      onChanged: (val) {
                        controller.statusFilter[key] = val ?? false;
                        controller.update();
                      },
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    );
                  }).toList(),

                  const Spacer(),

                  // Apply button
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        controller.filteredLogs.clear();
                        final selectedStatuses = controller.statusFilter.entries
                            .where((entry) => entry.value)
                            .map((entry) => entry.key)
                            .toSet();
                       //  await controller.fetchProperties(context);
                         print('${controller.postcodeFilter.toString()}hjkk');
                        await controller.applyFilters(
                          postcodeContains: controller.postcodeFilter,
                          machineIdEquals: controller.machineFilter,
                          statusIn: selectedStatuses,
                        );

                        Navigator.of(context).pop(); // Close drawer
                      },
                      child:  Text('Apply Filters',style: TextStyle(fontSize: s*.045, fontWeight: FontWeight.normal)),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  Future<void> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}