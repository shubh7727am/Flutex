import 'package:flutex_admin/core/utils/dimensions.dart';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/core/utils/style.dart';
import 'package:flutex_admin/data/controller/invoice/invoice_controller.dart';
import 'package:flutex_admin/data/model/invoice/invoice_details_model.dart';
import 'package:flutex_admin/view/components/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceDataTable extends StatelessWidget {
  final Map<String,dynamic> items ;
  InvoiceDataTable({super.key , required this.items});

  final columns = [
    LocalStrings.id.tr,
    LocalStrings.item.tr,
    LocalStrings.qty.tr,
    LocalStrings.rate.tr,
    LocalStrings.amount.tr
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceController>(builder: (controller) {
      return controller.isLoading
          ? const CustomLoader()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: DataTable(
                  columns: getColumns(columns),
                  rows: getRows([items]),
                ),
              ),
            );
    });
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column, style: regularDefault),
          ))
      .toList();

  List<DataRow> getRows(List<Map<String,dynamic>> items) => items
      .map((Map<String,dynamic> items) => DataRow(
            cells: [
              DataCell(SizedBox(
                width: 30,
                child: Text(items["itemId"]?? '', style: lightSmall),
              )),
              DataCell(SizedBox(
                width: 150,
                child: Text(
                  items["des"] ?? '',
                  style: lightSmall,
                  maxLines: 2,
                ),
              )),
              DataCell(SizedBox(
                width: 80,
                child: Text(
                    '${double.parse(items["quantity"] ?? '0').toInt()} ${items["unit"] ?? ''}',
                    style: lightSmall),
              )),
              DataCell(SizedBox(
                width: 80,
                child: Text(items["rate"].toString()?? '', style: lightSmall),
              )),
              DataCell(SizedBox(
                width: 80,
                child: Text(
                    (double.parse(items["quantity"]?? '') *
                            double.parse(items["rate"].toString()?? ''))
                        .toString(),
                    style: lightSmall),
              )),
            ],
          ))
      .toList();
}
