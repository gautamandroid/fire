import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_search_crud/app/modules/home/controller/home_controller.dart';
import 'package:firebase_search_crud/app/modules/login/view/login_view.dart';
import 'package:firebase_search_crud/widgets/global_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_theme_data.dart';
import '../../../../widgets/text_field.dart';
import '../../../../widgets/text_view.dart';
import '../../../models/addDataModel.dart';
import '../widgets/add_document_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const TextView(text: 'Home Screen'), backgroundColor: AppThemeData.blue),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppThemeData.blue,
            foregroundColor: AppThemeData.grey25,
            onPressed: () async {
             // await  FirebaseAuth.instance.signOut();
              controller.nameController.value.clear();
              controller.surnameController.value.clear();
              controller.addDataModel.value = AddDataModel();
              Get.to(() => AddDocumentView());
              // Get.off(() => LoginView());
            },
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [

                Obx(() => CustomTextFormField(
                  title: "search".tr,
                  hintText: "Enter name".tr,
                  onChanged: (value) {
                    controller.filterSearchResults(value);

                  },
                  controller: controller.searchController.value,
                  suffix: GestureDetector(
                    onTap: () {
                      if (controller.searchText.value.isNotEmpty) {
                        controller.searchController.value.clear();

                        controller.filterSearchResults('');
                      }
                    },
                    child: Icon(
                      controller.searchText.value.isEmpty ? Icons.search : Icons.close,
                      color: AppThemeData.grey800,
                    ),
                  ),
                  onPress: () {},
                )),

                spaceH(height: 30),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.modelDataList.isEmpty) {
                    return const Center(child: TextView(text: 'No data found.'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.modelDataList.length,
                    itemBuilder: (context, index) {
                      final data = controller.modelDataList[index];
                      return Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [TextView(text: 'Name: ${data.name}', maxLines: 1), TextView(text: 'Surname: ${data.surName}', maxLines: 1)],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    controller.isEdit.value = true;
                                    controller.getArgument(data);
                                    Get.to(() => AddDocumentView());
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    controller.deleteData(data.id ?? '');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
