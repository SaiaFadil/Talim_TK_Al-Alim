import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:talim/src/CustomText.dart';
import 'package:talim/src/customColor.dart';

class SemuaAgenda extends StatefulWidget {
  const SemuaAgenda({super.key});

  @override
  State<SemuaAgenda> createState() => _SemuaAgendaState();
}

class _SemuaAgendaState extends State<SemuaAgenda> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<Map<String, dynamic>> agendaJson = [
    {
      "tanggal": "2025-07-06",
      "judul": "Perayaan Tahun Baru",
      "jam": "07.30",
      "lokasi": "Aula TK",
      "tipe": "Acara"
    },
    {
      "tanggal": "2025-07-06",
      "judul": "Perpisahan",
      "jam": "07.30",
      "lokasi": "Aula TK",
      "tipe": "Acara"
    },
    {
      "tanggal": "2025-07-15",
      "judul": "Rapat Guru",
      "jam": "09.00",
      "lokasi": "Ruang Guru",
      "tipe": "Rapat"
    },
  ];

  Map<DateTime, List<Map<String, dynamic>>> _events = {};

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    Map<DateTime, List<Map<String, dynamic>>> eventMap = {};
    for (var item in agendaJson) {
      DateTime date = DateTime.parse(item['tanggal']);
      DateTime dateOnly = DateTime(date.year, date.month, date.day);
      eventMap.putIfAbsent(dateOnly, () => []);
      eventMap[dateOnly]!.add(item);
    }
    setState(() {
      _events = eventMap;
    });
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> agendaBulanIni = agendaJson
        .where((e) =>
            DateTime.parse(e['tanggal']).month == _focusedDay.month &&
            DateTime.parse(e['tanggal']).year == _focusedDay.year)
        .toList();

    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        backgroundColor: CustomColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: CustomColors.blackColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Agenda Sekolah",
            style: CustomText.TextSfProBold(16, CustomColors.blackColor)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Kalender
            Container(
                decoration: BoxDecoration(
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: CustomColors.greyBackground2),
                ),
                child: TableCalendar(
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: _getEventsForDay,
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextFormatter: (date, locale) =>
                        DateFormat.yMMMM(locale).format(date),
                    titleTextStyle:
                        CustomText.TextSfProBold(16, CustomColors.blackColor),
                    leftChevronIcon: Icon(Icons.chevron_left,
                        color: CustomColors.blackColor),
                    rightChevronIcon: Icon(Icons.chevron_right,
                        color: CustomColors.blackColor),
                  ),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      bool hasEvent = _events
                          .containsKey(DateTime(day.year, day.month, day.day));
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: hasEvent
                              ? CustomColors.primarySoft
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: CustomText.TextSfPro(
                              14,
                              hasEvent
                                  ? CustomColors.primary
                                  : CustomColors.blackColor,
                            ),
                          ),
                        ),
                      );
                    },
                    todayBuilder: (context, day, focusedDay) {
                      bool hasEvent = _events
                          .containsKey(DateTime(day.year, day.month, day.day));
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: hasEvent
                              ? CustomColors.primary
                              : CustomColors.primary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: CustomText.TextSfProBold(
                              14,
                              CustomColors.whiteColor,
                            ),
                          ),
                        ),
                      );
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: CustomColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: CustomText.TextSfProBold(
                              14,
                              CustomColors.whiteColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Warna untuk hari ini
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text("Hari ini",
                        style:
                            CustomText.TextSfPro(12, CustomColors.blackColor)),
                  ],
                ),
                const SizedBox(width: 16),
                // Warna untuk ada agenda
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: CustomColors.primarySoft,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text("Ada agenda",
                        style:
                            CustomText.TextSfPro(12, CustomColors.blackColor)),
                  ],
                ),
                const SizedBox(width: 16),
                // Warna untuk hari ini + ada agenda
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: CustomColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text("Hari ini & agenda",
                        style:
                            CustomText.TextSfPro(12, CustomColors.blackColor)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Agenda Bulan Ini
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Agenda Bulan Ini",
                  style: CustomText.TextSfProBold(14, CustomColors.blackColor)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: agendaBulanIni.length,
                itemBuilder: (context, index) {
                  var item = agendaBulanIni[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CustomColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: CustomColors.greyBackground2),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: CustomColors.primarySoft,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.calendar_month,
                              color: CustomColors.primary, size: 28),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['judul'],
                                  style: CustomText.TextSfProBold(
                                      14, CustomColors.blackColor)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      size: 14, color: CustomColors.greyText),
                                  const SizedBox(width: 4),
                                  Text(item['jam'],
                                      style: CustomText.TextSfPro(
                                          12, CustomColors.greyText)),
                                  const SizedBox(width: 12),
                                  Icon(Icons.location_on,
                                      size: 14, color: CustomColors.greyText),
                                  const SizedBox(width: 4),
                                  Text(item['lokasi'],
                                      style: CustomText.TextSfPro(
                                          12, CustomColors.greyText)),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: CustomColors.primarySoft,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(item['tipe'],
                              style: CustomText.TextSfPro(
                                  10, CustomColors.primary)),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
