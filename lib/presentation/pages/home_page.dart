import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:libura/controllers/holiday_controller.dart';
import 'package:libura/utils/constants.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HolidayController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text(
                'Sekarang',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                DateFormat('dd MMM').format(DateTime.now()),
                style: TextStyle(
                  height: .8,
                  fontSize: 85,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                controller.nextHolidayCountdown.value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'Libur',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.holidays.length,
                itemBuilder: (context, index) {
                  final data = controller.holidays[index];
                  bool isSameDate = DateTime.parse(data.masehi)
                      .isAtSameMomentAs(DateTime.now());
                  return Container(
                    width: double.infinity,
                    height: 180,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.tertiary.withValues(alpha: .8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isSameDate
                            ? Text(
                                'Hari Ini',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              )
                            : const SizedBox(),
                        Text(
                          data.holiday.name,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          DateFormat('dd MMMM y')
                              .format(DateTime.parse(data.masehi)),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
