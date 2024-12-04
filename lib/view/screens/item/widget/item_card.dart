import 'package:flutex_admin/core/route/route.dart';
import 'package:flutex_admin/core/utils/color_resources.dart';
import 'package:flutex_admin/core/utils/dimensions.dart';
import 'package:flutex_admin/core/utils/style.dart';
import 'package:flutex_admin/data/model/item/item_model.dart';
import 'package:flutex_admin/view/components/divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../item_details_screen.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,

    required this.itemModel,
  });

  final Map<String,dynamic> itemModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailsScreen(itemDetails: itemModel,)));
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: const Border(
                left: BorderSide(
                  width: 5.0,
                  color: ColorResources.blueColor,
                ),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${itemModel["name"]}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                '${itemModel["longDes"]}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: lightSmall.copyWith(
                                    color: ColorResources.blueGreyColor),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${itemModel["rate"]}',
                              style: regularDefault,
                            ),
                            Text(
                              '${itemModel["unit"]}',
                              style: lightSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const CustomDivider(space: Dimensions.space10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextIcon(
                          text: '${itemModel["category"]}',
                          prefix: const Icon(
                            Icons.layers_rounded,
                            color: ColorResources.primaryColor,
                            size: 14,
                          ),
                          edgeInsets: EdgeInsets.zero,
                          textStyle: lightSmall.copyWith(
                              color: ColorResources.blueGreyColor),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
