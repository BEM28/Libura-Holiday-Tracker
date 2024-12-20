class Holiday {
  final String masehi;
  final HolidayDetail holiday;

  Holiday({required this.masehi, required this.holiday});

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      masehi: json['masehi'],
      holiday: HolidayDetail.fromJson(json['holiday']),
    );
  }
}

class HolidayDetail {
  final String name;

  HolidayDetail({
    required this.name,
  });

  factory HolidayDetail.fromJson(Map<String, dynamic> json) {
    return HolidayDetail(
      name: json['name'].toString().replaceAll('_', ' '),
    );
  }
}
