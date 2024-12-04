import 'package:flutex_admin/core/route/route.dart';
import 'package:flutex_admin/core/utils/color_resources.dart';
import 'package:flutex_admin/core/utils/dimensions.dart';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/core/utils/style.dart';
import 'package:flutex_admin/data/model/customer/customer_model.dart';
import 'package:flutex_admin/view/components/circle_avatar_with_letter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersCard extends StatelessWidget {
  const CustomersCard({
    super.key,

    required this.customerModel,
  });

  final Map<String,dynamic> customerModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.customerDetailsScreen,
            arguments: customerModel["id"]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space5),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.cardRadius),
              color: Theme.of(context).cardColor,
            ),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.space15,
                    vertical: Dimensions.space10),
                leading: CircleAvatarWithInitialLetter(
                  initialLetter: customerModel["name"]?? '',
                ),
                title: Text(customerModel["name"]?? '',
                    overflow: TextOverflow.ellipsis,
                    style: regularDefault.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium!.color)),
                subtitle: Text(
                  customerModel["contact"]?? '',
                  style: regularSmall.copyWith(color: ColorResources.blueColor),
                ),
                trailing: Container(
                    padding: const EdgeInsets.all(Dimensions.space5),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.cardRadius),
                        side: BorderSide(
                            color: customerModel["status"] == "active"
                                ? ColorResources.greenColor
                                : ColorResources.redColor),
                      ),
                    ),
                    child: Text(
                        customerModel["status"] == "active"
                          ? LocalStrings.active.tr
                          : LocalStrings.notActive.tr,
                      style: regularSmall.copyWith(
                          color: customerModel["status"] == "active"
                              ? ColorResources.greenColor
                              : ColorResources.redColor),
                    )))),
      ),
    );
  }
}
