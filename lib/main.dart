import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // для GoRouter
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_test_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://cirljvnifsjeqelaarjd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpcmxqdm5pZnNqZXFlbGFhcmpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI2MTAwOTIsImV4cCI6MjA3ODE4NjA5Mn0.VKCuMCeeLsbF80p1D7M5GNkZwN1___uxn57uV_9Tm94',
    debug: true,
  );

  runApp(const MyApp());
}

// Настройка маршрутизатора GoRouter (для лабораторной №2 и №3)
final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/second', builder: (context, state) => const SecondPage()),
    // 🔹 Новый маршрут для лабораторной №3 (Supabase)
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
    // ✅ Используем MaterialApp.router для GoRouter
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

// Главная страница
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
        Container(height: 50, width: 200),
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
          print('FAB нажата'); // демонстрация свойства onPressed
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
                  // ✅ Лабораторная №1 — базовая навигация
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SecondPage(),
                        ),
                      );
                    },
                    child: const Text('Перейти (Navigator.push)'),
                  ),
                  const SizedBox(height: 10),

                  // ✅ Лабораторная №2 — Named routes (через GoRouter)
                  ElevatedButton(
                    onPressed: () {
                      context.go('/second');
                    },
                    child: const Text('Перейти (GoRouter)'),
                  ),
                  // ✅ Лабораторная №3 — работа с Supabase
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

// Вторая страница
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вторая страница')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Это вторая страница!', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),

            // ✅ Возврат (Navigator.pop)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Назад (Navigator.pop)'),
            ),
            const SizedBox(height: 10),

            // ✅ Возврат через GoRouter
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Назад (GoRouter)'),
            ),
          ],
        ),
      ),
    );
  }
}
