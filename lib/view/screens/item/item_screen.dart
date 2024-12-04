import 'package:firebase_core/firebase_core.dart';
import 'package:flutex_admin/assignment_work/firebase_functions.dart';
import 'package:flutex_admin/core/utils/color_resources.dart';
import 'package:flutex_admin/core/utils/dimensions.dart';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/data/controller/item/item_controller.dart';
import 'package:flutex_admin/data/repo/item/item_repo.dart';
import 'package:flutex_admin/data/services/api_service.dart';
import 'package:flutex_admin/view/components/app-bar/custom_appbar.dart';
import 'package:flutex_admin/view/components/custom_loader/custom_loader.dart';
import 'package:flutex_admin/view/components/no_data.dart';
import 'package:flutex_admin/view/screens/item/widget/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<Map<String,dynamic>> items = [];
  @override
  void initState() {
    // Get.put(ApiClient(sharedPreferences: Get.find()));
    // Get.put(ItemRepo(apiClient: Get.find()));
    final controller = Get.put(ItemController());
    controller.isLoading = true;
    loadItems();
    super.initState();
    controller.isLoading = false;
    
  }
  
  loadItems()async{
    await FirebaseFetch.fetchDetails(collectionName: "Items").then((value) {
      setState(() {
        items = value;
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocalStrings.items.tr,
      ),
      body: items.isEmpty
              ? const CustomLoader()
              : RefreshIndicator(
                  onRefresh: () async {
                    //await controller.initialData(shouldLoad: false);
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.space15),
                        child: Row(
                          children: [
                            Text(
                              LocalStrings.items.tr,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.sort_outlined,
                                    size: Dimensions.space20,
                                    color: ColorResources.blueGreyColor,
                                  ),
                                  const SizedBox(width: Dimensions.space5),
                                  Text(
                                    LocalStrings.filter.tr,
                                    style: const TextStyle(
                                        fontSize: Dimensions.fontDefault,
                                        color: ColorResources.blueGreyColor),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.space15),
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return ItemCard(

                                        itemModel: items[index],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                            height: Dimensions.space10),
                                    itemCount:
                                        items.length),
                              ),
                            ),
                    ],
                  ),



    ),);
  }
}
