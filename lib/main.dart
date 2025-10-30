import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Корневой виджет приложения
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // теперь это главная страница
    );
  }
}

// Главная страница приложения
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
    return Column(
      children: const [
        Text("date"),
        Text("date2"),
        Text("date3"),
      ],
    );
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
      children: [
        currencyMenuItem(),
        currencyMenuItem(),
        currencyMenuItem(),
      ],
    );
  }

  Widget headerTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(radius: 30),
        Container(
          height: 50,
          width: 200,
        ),
      ],
    );
  }

  Widget headerContent() {
    return Row(
      children: [
        Column(
          children: const [
            SizedBox(height: 15),
            SizedBox(width: 100, child: Text("first text")),
            SizedBox(width: 100, child: Text("second text")),
            SizedBox(height: 15),
          ],
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
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [headerTop(), headerContent()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная страница')),
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
              child: ElevatedButton(
                onPressed: () {
                  // вот теперь контекст работает правильно!
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondPage()),
                  );
                },
                child: const Text('Перейти на вторую страницу'),
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
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // вернуться назад
              },
              child: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}
