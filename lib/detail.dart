import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

class DetailApp extends StatefulWidget {
  final int eventId;
  const DetailApp({super.key, required this.eventId});

  @override
  State<DetailApp> createState() => _DetailAppState();
}

class _DetailAppState extends State<DetailApp> {
  Map<String, dynamic>? event;

  Future<void> loadEvent() async {
    final data = await Supabase.instance.client
        .from('events')
        .select()
        .eq('id', widget.eventId)
        .single();

    setState(() {
      event = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getPageIndex(context),
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

      appBar: AppBar(title: const Text('Детали события')),
      body: event == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event!['title'] ?? 'Без названия',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Дата: ${event!['date']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    event!['description'] ?? 'Описание отсутствует',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }

  int _getPageIndex(BuildContext context) {
    final state = GoRouterState.of(context);
    final location = state.uri.toString();

    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/second')) return 1;
    if (location.startsWith('/supabase')) return 2;

    return 0;
  }
}
