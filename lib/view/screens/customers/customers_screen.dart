import 'package:flutex_admin/assignment_work/firebase_functions.dart';
import 'package:flutex_admin/core/route/route.dart';
import 'package:flutex_admin/core/utils/color_resources.dart';
import 'package:flutex_admin/core/utils/dimensions.dart';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/core/utils/style.dart';
import 'package:flutex_admin/data/controller/customer/customer_controller.dart';
import 'package:flutex_admin/data/controller/home/home_controller.dart';
import 'package:flutex_admin/data/repo/customer/customer_repo.dart';
import 'package:flutex_admin/data/repo/home/home_repo.dart';
import 'package:flutex_admin/data/services/api_service.dart';
import 'package:flutex_admin/view/components/app-bar/custom_appbar.dart';
import 'package:flutex_admin/view/components/custom_fab.dart';
import 'package:flutex_admin/view/components/custom_loader/custom_loader.dart';
import 'package:flutex_admin/view/components/no_data.dart';
import 'package:flutex_admin/view/screens/customers/widgets/customers_card.dart';
import 'package:flutex_admin/view/screens/home/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {

  List<Map<String, dynamic>> documentsCustomer = [];
  @override
  void initState() {
    //Get.put(ApiClient(sharedPreferences: Get.find()));
   // Get.put(CustomerRepo(apiClient: Get.find()));
    //final controller = Get.put(CustomerController(customerRepo: Get.find()));
   // Get.put(HomeRepo(apiClient: Get.find()));
   // final homeController = Get.put(HomeController(homeRepo: Get.find()));
   // controller.isLoading = true;
    fetchCustomerData();
    super.initState();
    handleScroll();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   controller.initialData();
    //   homeController.initialData();
    // });
  }

  fetchCustomerData()async{
    await FirebaseFetch.fetchDetails(collectionName: "Customers").then((value) {
      setState(() {
        documentsCustomer = value;
      });

    });
  }



  bool showFab = true;
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  void handleScroll() async {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (showFab) setState(() => showFab = false);
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!showFab) setState(() => showFab = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocalStrings.customers.tr,
      ),
      floatingActionButton: AnimatedSlide(
        offset: showFab ? Offset.zero : const Offset(0, 2),
        duration: const Duration(milliseconds: 300),
        child: AnimatedOpacity(
          opacity: showFab ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: CustomFAB(
              isShowIcon: true,
              isShowText: false,
              press: () {
                Get.toNamed(RouteHelper.addCustomerScreen);
              }),
        ),
      ),
      body: documentsCustomer.isEmpty
              ? const CustomLoader()
              : RefreshIndicator(
                  color: ColorResources.primaryColor,
                  onRefresh: () async {
                    //await controller.initialData(shouldLoad: false);
                   // homeController.initialData();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionTile(
                        title: Text(
                          LocalStrings.customerSummery,
                          style: regularLarge.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                        ),
                        shape: const Border(),
                        initiallyExpanded: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.space15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomContainer(
                                        name: LocalStrings.totalCustomers.tr,
                                        number: documentsCustomer.length.toString(),
                                        icon: Icons.group,
                                        color: ColorResources.blueColor),
                                    const SizedBox(width: Dimensions.space10),
                                    CustomContainer(
                                        name: LocalStrings.activeCustomers.tr,
                                        number: documentsCustomer.where((element) => element["status"] == "active").length.toString(),
                                        icon: Icons.group_add,
                                        color: ColorResources.greenColor),
                                    const SizedBox(width: Dimensions.space10),
                                    CustomContainer(
                                        name: LocalStrings.inactiveCustomers.tr,
                                        number: documentsCustomer.where((element) => element["status"] == "inactive").length.toString(),
                                        icon: Icons.group_remove,
                                        color: ColorResources.redColor),
                                  ],
                                ),
                                const SizedBox(height: Dimensions.space10),
                                Row(
                                  children: [
                                    CustomContainer(
                                        name: LocalStrings.activeContacts.tr,
                                        number: documentsCustomer.where((element) => element["contact"] != "").length.toString(),
                                        icon: Icons.add_circle_outline_outlined,
                                        color: ColorResources.greenColor),
                                    const SizedBox(width: Dimensions.space10),
                                    CustomContainer(
                                        name: LocalStrings.inactiveContacts.tr,
                                        number: documentsCustomer.where((element) => element["contact"] == "").length.toString(),
                                        icon: Icons
                                            .remove_circle_outline_outlined,
                                        color: ColorResources.redColor),
                                    const SizedBox(width: Dimensions.space10),
                                    CustomContainer(
                                        name: LocalStrings.lastLoginContacts.tr,
                                        number: "--",
                                        icon: Icons.login_rounded,
                                        color: ColorResources.yellowColor),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.space15),
                        child: Row(
                          children: [
                            Text(
                              LocalStrings.customers.tr,
                              style: regularLarge.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color),
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
                      documentsCustomer.isNotEmpty
                          ? Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.space15),
                                child: ListView.builder(
                                    controller: scrollController,
                                    itemBuilder: (context, index) {
                                      return CustomersCard(customerModel: documentsCustomer[index] );
                                    },
                                    itemCount:
                                        documentsCustomer.length),
                              ),
                            )
                          : const NoDataWidget(),
                    ],
                  ),
                ),

    );
  }
}
