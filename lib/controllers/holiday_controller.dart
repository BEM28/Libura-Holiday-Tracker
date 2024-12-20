import 'package:get/get.dart';
import 'package:libura/data/repositories/api_client.dart';
import '../data/models/holiday_model.dart';

class HolidayController extends GetxController {
  final ApiClient apiClient = ApiClient();
  final RxList<Holiday> holidays = <Holiday>[].obs;
  final RxBool isLoading = false.obs;
  final RxString nextHolidayCountdown = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHolidays();
  }

  Future<void> fetchHolidays() async {
    try {
      String year = DateTime.now().year.toString();
      isLoading.value = true;
      final fetchedHolidays = await apiClient.fetchHolidays('2025');

      // Filter holiday yang sudah lewat
      final upcomingHolidays = fetchedHolidays.where((holiday) {
        DateTime holidayDate = DateTime.parse(holiday.masehi);
        return holidayDate.isAfter(DateTime.now());
      }).toList();

      // Mengurutkan berdasarkan tanggal holiday
      upcomingHolidays.sort((a, b) {
        DateTime dateA = DateTime.parse(a.masehi);
        DateTime dateB = DateTime.parse(b.masehi);
        return dateA.compareTo(dateB);
      });

      holidays.assignAll(upcomingHolidays);

      // Hitung hari ke depan untuk holiday terdekat
      _calculateNextHolidayCountdown();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk menghitung berapa hari lagi menuju holiday terdekat
  void _calculateNextHolidayCountdown() {
    if (holidays.isNotEmpty) {
      DateTime nextHolidayDate = DateTime.parse(holidays.first.masehi);
      int daysLeft = nextHolidayDate.difference(DateTime.now()).inDays;

      if (daysLeft > 0) {
        nextHolidayCountdown.value =
            '$daysLeft hari lagi menuju\n${holidays.first.holiday.name}';
      } else {
        nextHolidayCountdown.value =
            'Hari ini adalah ${holidays.first.holiday.name}';
      }
    }
  }
}
