import 'package:flutter/material.dart';
import 'package:flutter_application_2/detail.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_test_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'auth_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://frvexfoezbscdbcvuxas.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZydmV4Zm9lemJzY2RiY3Z1eGFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk3NDY4ODgsImV4cCI6MjA3NTMyMjg4OH0.XDr9MFxBMX0P42a4MwjstxtZeh_Caqdyrfpfr7d9ec8',
    debug: true,
  );

  runApp(const MyApp());
}

/// ----------------------
/// GoRouter
/// ----------------------
final GoRouter router = GoRouter(
  routes: [
    /// Детальная страница события
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return DetailApp(eventId: id);
      },
    ),

    /// Старт – авторизация
    GoRoute(path: '/', builder: (context, state) => const AuthPage()),

    /// Главная после входа
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),

    /// Календарь
    GoRoute(path: '/second', builder: (context, state) => const SecondPage()),

    /// Таблица событий (Supabase)
    GoRoute(
      path: '/supabase',
      builder: (context, state) => const SupabaseTestPage(),
    ),
  ],
);

/// ----------------------
/// Основное приложение
/// ----------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Festival App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF8ECFF),
      ),
    );
  }
}

/// ------------------------------------------------------
/// ГЛАВНАЯ СТРАНИЦА (ЛР1–3) – фестивальная тема
/// ------------------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget currencyMenuItem(String title, String subtitle) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
            "https://thumbs.dreamstime.com/b/%D0%BF-%D0%B0%D0%BA%D0%B0%D1%82-%D0%BC%D1%83%D0%B7%D1%8B%D0%BA%D0%B0-%D1%8C%D0%BD%D0%BE%D0%B3%D0%BE-%D1%84%D0%B5%D1%81%D1%82%D0%B8%D0%B2%D0%B0-%D1%8F-45620147.jpg",
          ),
          backgroundColor: Colors.transparent,
        ),

        const SizedBox(height: 8),
        Text(title),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  Widget calendarItem(String line1, String line2, String line3) {
    return Column(children: [Text(line1), Text(line2), Text(line3)]);
  }

  Widget calendar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        calendarItem('15 июня', 'Рок-фест', 'Парк города'),
        calendarItem('20 июня', 'Джаз-ночь', 'Филармония'),
        calendarItem('1 июля', 'Классика', 'Открытая сцена'),
        calendarItem('5 июля', 'Поп-фест', 'Стадион'),
        calendarItem('10 июля', 'Фолк', 'Площадь'),
      ],
    );
  }

  Widget currencyList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Text('10'),
            SizedBox(width: 5),
            Text('фестивалей этим летом'),
          ],
        ),
        Container(color: Colors.deepPurpleAccent, width: 100, height: 100),
      ],
    );
  }

  Widget currencyMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        currencyMenuItem('Рок', 'Энергичные концерты'),
        currencyMenuItem('Джаз', 'Уютные вечера'),
        currencyMenuItem('Классика', 'Симфонические шоу'),
      ],
    );
  }

  Widget headerTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        CircleAvatar(radius: 30),
        SizedBox(height: 50, width: 200),
      ],
    );
  }

  Widget headerContent() {
    return Row(
      children: const [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(
                'Летние музыкальные фестивали',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  'Выбирайте жанр, дату и площадку — планируйте своё фестивальное лето!',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }

  Widget header() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC9oAcZGVBuUU-UWGa-j9tZIzh4vS4HKLvbA&s',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: [headerTop(), headerContent()]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Фестивальное лето')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint('FAB нажата'),
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) context.go('/home');
          if (index == 1) context.go('/second');
          if (index == 2) context.go('/supabase');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Календарь',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'События'),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Жанры фестивалей',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            currencyMenu(),

            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Ближайшие даты',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            calendar(),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: currencyList(),
            ),

            const SizedBox(height: 40),

            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => context.go('/second'),
                    child: const Text('Открыть календарь (ЛР2–3)'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => context.go('/supabase'),
                    child: const Text('Проверить Supabase (ЛР3)'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------
/// СТРАНИЦА 2 – календарь фестивалей c Supabase + ближайшая дата
/// ------------------------------------
class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  /// { DateTime(2025, 6, 15): [ {id:1, title:'Rock', date:'2025-06-15'} ] }
  Map<DateTime, List<Map<String, dynamic>>> eventsMap = {};

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  /// Загружаем фестивали из Supabase
  Future<void> loadEvents() async {
    final data = await Supabase.instance.client.from('events').select('*');

    final Map<DateTime, List<Map<String, dynamic>>> newMap = {};

    for (var e in data) {
      if (e['date'] == null) continue;

      DateTime fullDate = DateTime.parse(e['date']);
      DateTime dayKey = DateTime(fullDate.year, fullDate.month, fullDate.day);

      if (!newMap.containsKey(dayKey)) {
        newMap[dayKey] = [];
      }
      newMap[dayKey]!.add(e);
    }

    setState(() {
      eventsMap = newMap;
      loading = false;
    });
  }

  /// Получить список событий на определённый день
  List<Map<String, dynamic>> loadEventsOnDay(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return eventsMap[key] ?? [];
  }

  /// Найти последний фестиваль (самую позднюю дату)
  DateTime? getLastFestivalDate() {
    if (eventsMap.isEmpty) return null;

    List<DateTime> allDates = eventsMap.keys.toList();

    allDates.sort(); // сортировка по возрастанию
    return allDates.last; // последняя дата
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Календарь фестивалей')),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) context.go('/home');
          if (index == 1) context.go('/second');
          if (index == 2) context.go('/supabase');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Календарь',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'События'),
        ],
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  /// Календарь
                  TableCalendar(
                    eventLoader: loadEventsOnDay,
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: focusedDay,
                    selectedDayPredicate: (day) => isSameDay(selectedDay, day),

                    onDaySelected: (selected, focused) {
                      final events = loadEventsOnDay(selected);

                      setState(() {
                        selectedDay = selected;
                        focusedDay = focused;
                      });

                      if (events.isNotEmpty) {
                        // Показать всплывающий hint
                        showDialog(
                          context: context,
                          builder: (context) {
                            final event = events.first;
                            return AlertDialog(
                              title: Text(event['title']),
                              content: Text(
                                event['description'] ?? 'Нет описания',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    context.go('/detail/${event['id']}');
                                  },
                                  child: const Text('Подробнее'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Закрыть'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },

                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.pink,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                    ),

                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, events) {
                        if (events.isNotEmpty) {
                          return Positioned(
                            bottom: 4,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.deepPurple,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Кнопка — перейти к последнему фестивалю
                  ElevatedButton(
                    onPressed: () {
                      final last = getLastFestivalDate();

                      if (last != null) {
                        setState(() {
                          selectedDay = last;
                          focusedDay = last;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Фестивалей в календаре нет"),
                          ),
                        );
                      }
                    },
                    child: const Text("Перейти к последнему фестивалю"),
                  ),

                  const SizedBox(height: 25),

                  if (selectedDay != null)
                    Text(
                      'Вы выбрали: '
                      '${selectedDay!.day}.${selectedDay!.month}.${selectedDay!.year}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  else
                    const Text(
                      'Выберите дату фестиваля',
                      style: TextStyle(fontSize: 16),
                    ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }
}
