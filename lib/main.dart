import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_test_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'auth_page.dart'; // ✅ подключаем страницу авторизации

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

// ✅ Настройка маршрутизатора GoRouter (теперь добавлен AuthPage)
final GoRouter router = GoRouter(
  routes: [
    // 🔹 Стартовая страница — авторизация
    GoRoute(path: '/', builder: (context, state) => const AuthPage()),

    // 🔹 Главная страница после входа
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),

    // 🔹 Страница с календарём
    GoRoute(path: '/second', builder: (context, state) => const SecondPage()),

    // 🔹 Страница Supabase (для проверки)
    GoRoute(
      path: '/supabase',
      builder: (context, state) => const SupabaseTestPage(),
    ),
  ],
);

// Основное приложение
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Flutter Demo App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}

// -------------------
// Главная страница (ЛР1–3)
// -------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget currencyMenuItem() {
    return Column(
      children: const [
        CircleAvatar(radius: 20),
        Text("some text"),
        Text("some text"),
      ],
    );
  }

  Widget calendarItem() {
    return Column(children: const [Text("date"), Text("date2"), Text("date3")]);
  }

  Widget calendar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        calendarItem(),
        calendarItem(),
        calendarItem(),
        calendarItem(),
        calendarItem(),
      ],
    );
  }

  Widget currencyList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: const [Text('1'), SizedBox(width: 5), Text('___2')]),
        Container(color: Colors.red, width: 100, height: 100),
      ],
    );
  }

  Widget currencyMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [currencyMenuItem(), currencyMenuItem(), currencyMenuItem()],
    );
  }

  Widget headerTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(radius: 30),
        SizedBox(height: 50, width: 200),
      ],
    );
  }

  Widget headerContent() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 15),
              SizedBox(width: 100, child: Text("first text")),
              SizedBox(width: 100, child: Text("second text")),
              SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }

  Widget header() {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.red,
        image: DecorationImage(
          image: NetworkImage(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
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
      appBar: AppBar(title: const Text('Главная страница')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB нажата');
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            const SizedBox(height: 20),
            currencyMenu(),
            const SizedBox(height: 20),
            calendar(),
            const SizedBox(height: 20),
            currencyList(),
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.go('/second');
                    },
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
          ],
        ),
      ),
    );
  }
}

// -------------------
// Вторая страница (с календарём)
// -------------------
class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Календарь (ЛР3)')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: (selected, focused) {
                setState(() {
                  selectedDay = selected;
                  focusedDay = focused;
                });
              },
              calendarFormat: CalendarFormat.month,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (selectedDay != null)
              Text(
                'Вы выбрали: ${selectedDay!.day}.${selectedDay!.month}.${selectedDay!.year}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )
            else
              const Text(
                'Выберите дату на календаре',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            const Divider(height: 40, thickness: 1),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Назад (GoRouter)'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
