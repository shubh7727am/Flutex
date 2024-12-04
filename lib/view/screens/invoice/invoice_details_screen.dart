import 'package:flutex_admin/core/helper/string_format_helper.dart';
import 'package:flutex_admin/core/utils/color_resources.dart';
import 'package:flutex_admin/core/utils/dimensions.dart';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/core/utils/style.dart';
import 'package:flutex_admin/data/controller/invoice/invoice_controller.dart';
import 'package:flutex_admin/data/repo/invoice/invoice_repo.dart';
import 'package:flutex_admin/data/services/api_service.dart';
import 'package:flutex_admin/view/components/app-bar/custom_appbar.dart';
import 'package:flutex_admin/view/components/custom_loader/custom_loader.dart';
import 'package:flutex_admin/view/components/no_data.dart';
import 'package:flutex_admin/view/screens/invoice/widget/invoice_datatable.dart';
import 'package:flutex_admin/view/screens/invoice/widget/transactions_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assignment_work/firebase_functions.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  const InvoiceDetailsScreen({super.key, required this.id});
  final String id;

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  List<Map<String,dynamic>> invoiceData = [];
  @override
  void initState() {
    // Get.put(ApiClient(sharedPreferences: Get.find()));
    // Get.put(InvoiceRepo(apiClient: Get.find()));
    final controller = Get.put(InvoiceController());
    controller.isLoading = true;
    loadInvoiceDetails(widget.id);
    controller.isLoading = false;
    super.initState();


  }

  loadInvoiceDetails(String id)async{

    FirebaseFetch.fetchInvoiceData(id).then((value){
      setState(() {
        invoiceData = value;
      });
      print(invoiceData);
    });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocalStrings.invoiceDetails.tr,
      ),
      body: invoiceData.isEmpty
              ? const CustomLoader()
              : RefreshIndicator(
                  color: ColorResources.primaryColor,
                  onRefresh: () async {
                    //await controller.initialData(shouldLoad: false);
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.space10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${invoiceData[0]["invoiceId"]}',
                                style: regularDefault,
                              ),
                              Container(
                                  padding:
                                      const EdgeInsets.all(Dimensions.space5),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.cardRadius),
                                      side: BorderSide(
                                          color:
                                              ColorResources.invoiceStatusColor(
                                                  invoiceData[0]["status"] ??
                                                      '')),
                                    ),
                                  ),
                                  child: Text(
                                    Converter.invoiceStatusString(invoiceData[0]["invoiceId"]??
                                        ''),
                                    style: regularSmall.copyWith(
                                        color:
                                            ColorResources.invoiceStatusColor(
                                                invoiceData[0]["invoiceId"] ??
                                                    '')),
                                  ))
                            ],
                          ),
                          const Divider(color: Colors.grey),
                          const SizedBox(height: Dimensions.space5),
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.space5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${LocalStrings.billTo.tr}: ${invoiceData[0]["client"]}',
                                  style: lightDefault,
                                ),
                                const SizedBox(height: Dimensions.space5),
                                Text(
                                  '${LocalStrings.invoiceDate.tr}: ${invoiceData[0]["date"]}',
                                  style: lightDefault,
                                ),
                                const SizedBox(
                                  height: Dimensions.space5,
                                ),
                                Text(
                                  '${LocalStrings.dueDate.tr}: ${invoiceData[1]["dueDate"]}',
                                  style: lightDefault,
                                ),
                                const SizedBox(height: Dimensions.space5),
                                Text(
                                  '${LocalStrings.project.tr}: ${invoiceData[0]["clientNote"]?? ''}',
                                  style: lightDefault,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: ColorResources.blueGreyColor,
                          ),
                          InvoiceDataTable(items: invoiceData[2],),
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.space5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      LocalStrings.subtotal.tr,
                                      style: regularDefault,
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Text(
                                      LocalStrings.total.tr,
                                      style: regularDefault,
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Text(
                                      LocalStrings.totalPaid.tr,
                                      style: regularDefault,
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Text(
                                      LocalStrings.amountDue.tr,
                                      style: regularDefault.copyWith(
                                          color: ColorResources.redColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: Dimensions.space15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${invoiceData[0]["subtotal"]} ${invoiceData[0]["currency"]}',
                                      style: mediumDefault,
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Text(
                                      '${invoiceData[0]["subtotal"]} ${invoiceData[0]["currency"]}',
                                      style: mediumDefault,
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    // Text(
                                    //   '- ${((invoiceData[0]["subtotal"] ?? '') - double.parse(invoiceData[0]["leftToPay"] ?? '')).toStringAsFixed(2)} ${invoiceData[0]["currency"]}',
                                    //   style: mediumDefault,
                                    // ),
                                    const SizedBox(height: Dimensions.space10),
                                    Text(
                                      '${invoiceData[0]["lefToPay"]} ${invoiceData[0]["currency"]}',
                                      style: mediumDefault.copyWith(
                                        fontWeight: FontWeight.w300,
                                        color: ColorResources.redColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            LocalStrings.transactions.tr,
                            style: regularDefault,
                          ),
                          const Divider(
                            color: ColorResources.blueGreyColor,
                          ),
                         const Center(
                                  child: NoDataWidget(),
                                ),
                        ],
                      ),
                    ),
                  ),



    ),
    );
  }
}
