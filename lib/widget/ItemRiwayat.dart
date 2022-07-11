// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, avoid_print, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:get/get.dart';
import 'package:turu_in/config/config.dart';
import 'package:turu_in/model/Booking.dart';
import 'package:turu_in/routes/routes.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:turu_in/utils/Currency.dart';

class ItemRiwayat extends StatelessWidget {
  final Booking item;

  ItemRiwayat({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: CustomTheme().turuInPrimary,
      splashColor: CustomTheme().turuInPrimary,
      focusColor: CustomTheme().turuInPrimary,
      highlightColor: CustomTheme().turuInPrimary,
      onTap: () {
        Get.toNamed(Routes.Detail, arguments: item, preventDuplicates: false);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        color: CustomTheme().turuInSecondary,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 83,
                                width: 123,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      item.hotelImage!,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FxText.titleMedium(
                                item.hotelName!,
                                color: Colors.white,
                                fontWeight: 700,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FxText.titleMedium(
                                item.hotelDistrictName! +
                                    ', ' +
                                    item.hotelCityName!,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromRGBO(49, 54, 66, 0.68),
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.titleMedium(
                        'Check in',
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      FxText.titleMedium(
                        getTanggal(DateTime.parse(item.dateStart!)),
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromRGBO(49, 54, 66, 0.68),
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.titleMedium(
                        'Check out',
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      FxText.titleMedium(
                        getTanggal(DateTime.parse(item.dateEnd!)),
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromRGBO(49, 54, 66, 0.68),
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.titleMedium(
                        'Status',
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      FxText.titleMedium(
                        item.status == 0 ? "Pending" : "Sukses",
                        color: item.status == 0
                            ? CustomTheme().turuInTersier
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromRGBO(49, 54, 66, 0.68),
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image(
                            image: AssetImage(
                              item.payment == 'gopay'
                                  ? 'assets/gojek.png'
                                  : item.payment == 'ovo'
                                      ? 'assets/ovo.png'
                                      : 'assets/money.png',
                            ),
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 14),
                          FxText.titleMedium(
                            item.payment == 'gopay'
                                ? 'GoPay'
                                : item.payment == 'ovo'
                                    ? "OVO"
                                    : "Cash",
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: 600,
                          ),
                        ],
                      ),
                      FxText.titleMedium(
                        formatRupiah(item.totalPrice!),
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // height: 190.0,
            width: MediaQuery.of(context).size.width - 100.0,
          ),
        ),
      ),
    );
  }
}
